import json
import uuid  # Unique session IDs
import pkg_resources
import random  # For adding response variations
from django.db.models import Q
from django.http import JsonResponse
from django.forms import ModelForm
from django.core.paginator import Paginator
from django.views.decorators.http import require_http_methods
from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Count, Avg, F, Q
from django.contrib.auth.hashers import make_password, check_password
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from django.utils import timezone
from django.conf import settings

import requests

from django.http import HttpResponse
from requests import session

from .models import Course, Fees, Admission, Contact, ChatbotResponse, ChatLog, Applicant, Applications, \
    CollegeManagement, Reminder
import spacy
from spacy.lang.en.stop_words import STOP_WORDS
import yake
from symspellpy import SymSpell, Verbosity
import pkg_resources
import nltk
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from .forms import EntranceExamRegistrationForm, ApplicantRegistrationForm, ApplicantLoginForm, ManagementLoginForm, \
    ManagementSignUpForm

# Download necessary NLTK resources (run once)
nltk.download("punkt", quiet=True)
nltk.download("stopwords", quiet=True)
nltk.download("wordnet", quiet=True)

# Load spaCy model
nlp = spacy.load("en_core_web_sm")

# Initialize SymSpell for spell checking
sym_spell = SymSpell(max_dictionary_edit_distance=2)
dictionary_path = pkg_resources.resource_filename("symspellpy", "frequency_dictionary_en_82_765.txt")
sym_spell.load_dictionary(dictionary_path, term_index=0, count_index=1)

# Initialize YAKE keyword extractor with improved parameters
yake_extractor = yake.KeywordExtractor(
    lan="en",
    n=3,  # Allow phrases up to 3 words
    dedupLim=0.8,  # Less strict deduplication
    windowsSize=3,  # Context window size
    top=8  # Extract more keywords for better matching
)

# Initialize lemmatizer
lemmatizer = WordNetLemmatizer()

# Greeting variations
GREETINGS = [
    "Hello there! What's your name?",
    "Hi! I'd love to know your name.",
    "Welcome! May I know your name?",
    "Greetings! What should I call you?"
]

# Response variations
FALLBACK_RESPONSES = [
    "I'm sorry, I don't have enough information about that. Could you please provide more details?",
    "I'm not sure I understood. Could you rephrase that or provide more context?",
    "I don't have specific information about that. Can you ask something else about our college?",
    "I couldn't find relevant information for that query. Would you like to know about our courses or admission process instead?"
]

# Error response variations
ERROR_RESPONSES = [
    "I apologize, but something went wrong. Please try again in a moment.",
    "Oops! There seems to be a technical issue. Please try again shortly.",
    "Sorry for the inconvenience. Our system is experiencing a hiccup. Please try again."
]


@csrf_exempt
def chatbot(request):
    if request.method == "POST":
        data = json.loads(request.body)
        user_message = data.get("message", "").strip()

        # Generate or retrieve session ID
        session_id = request.session.get("session_id")
        if not session_id:
            session_id = str(uuid.uuid4())  # Generate unique session ID
            request.session["session_id"] = session_id
            request.session["context"] = []  # Initialize context tracking
            request.session.modified = True

        # Retrieve session variables
        user_name = request.session.get("user_name")
        awaiting_name = request.session.get("awaiting_name", False)
        context = request.session.get("context", [])


        print(f"Session ID: {session_id}, User Name: {user_name}, Awaiting Name: {awaiting_name}, Context: {context}")


        if is_greeting(user_message.lower()):
            if user_name:
                return JsonResponse({"response": f"Hello again, {user_name}! How can I help you today?"})
            else:
                request.session["awaiting_name"] = True
                request.session.modified = True
                return JsonResponse({"response": random.choice(GREETINGS)})


        if not user_name and not awaiting_name:
            request.session["awaiting_name"] = True
            request.session.modified = True
            return JsonResponse({"response": random.choice(GREETINGS)})


        if awaiting_name:
            # Extract proper name from input
            doc = nlp(user_message)
            name_entities = [ent.text for ent in doc.ents if ent.label_ == "PERSON"]

            if name_entities:
                name = name_entities[0]
            else:
                # If no name entity was found, use the first capitalized word or the whole message
                tokens = user_message.split()
                name = next((token for token in tokens if token[0].isupper()), user_message)

            # Clean and capitalize name
            cleaned_name = name.strip().capitalize()

            request.session["user_name"] = cleaned_name
            request.session["awaiting_name"] = False
            request.session.modified = True

            # Add personalized greeting
            greeting_responses = [
                f"Nice to meet you, {cleaned_name}! How can I assist you today?",
                f"Hello {cleaned_name}! What can I help you with regarding our college?",
                f"Thanks, {cleaned_name}! What would you like to know about our institution?",
                f"Great, {cleaned_name}! I'm here to answer your questions about admissions, courses, or anything else related to our college."
            ]

            return JsonResponse({"response": random.choice(greeting_responses)})

        # Add user message to context
        context.append(user_message)
        if len(context) > 5:  # Keep only the 5 most recent messages for context
            context = context[-5:]
        request.session["context"] = context
        request.session.modified = True

        try:
            # Spell check and preprocess user message
            corrected_message = correct_spelling(user_message)
            print(f"Corrected Message: {corrected_message}")

            # Extract keywords with improved method
            keywords, phrases = extract_keywords_and_phrases(corrected_message, context)
            print(f"Extracted Keywords: {keywords}")
            print(f"Extracted Phrases: {phrases}")

            # Fetch chatbot response with context awareness
            bot_response = get_chatbot_response(keywords, phrases, context)

            # Add personalization and conversation markers
            bot_response = personalize_response(bot_response, user_name)

            # Store chat logs
            store_chat_log(session_id, user_name, user_message, bot_response)

            return JsonResponse({"response": bot_response})

        except Exception as e:
            print(f"Error in chatbot processing: {e}")
            return JsonResponse({"response": random.choice(ERROR_RESPONSES)})

    return JsonResponse({"response": "Invalid request method."})


def is_greeting(text):
    greeting_words = [
        "hello", "hi", "hey", "greetings", "good morning", "good afternoon",
        "good evening", "howdy", "sup", "what's up", "hola"
    ]
    return any(greeting in text for greeting in greeting_words)


def correct_spelling(text):
    # Don't correct common chat abbreviations, names, or technical terms
    ignore_words = set([
        "btw", "lol", "omg", "idk", "fyi", "asap", "bsc", "btech", "mtech", "phd",
        "cs", "it", "ece", "eee", "mca", "bca", "gpa", "cgpa"
    ])

    sentences = sent_tokenize(text)
    corrected_sentences = []

    for sentence in sentences:
        words = word_tokenize(sentence)
        corrected_words = []

        for word in words:
            # Skip correction for short words, numbers, acronyms, and words to ignore
            if (len(word) <= 2 or word.lower() in ignore_words or
                    any(c.isdigit() for c in word) or word.isupper()):
                corrected_words.append(word)
                continue

            # Check if word needs correction
            suggestions = sym_spell.lookup(word.lower(), Verbosity.CLOSEST, max_edit_distance=2)
            if suggestions and suggestions[0].term != word.lower():
                # Only replace if confidence is high
                if suggestions[0].distance <= 1:  # Only correct if edit distance is 1 or less
                    # Preserve original capitalization
                    if word.istitle():
                        corrected_words.append(suggestions[0].term.title())
                    elif word.isupper():
                        corrected_words.append(suggestions[0].term.upper())
                    else:
                        corrected_words.append(suggestions[0].term)
                else:
                    corrected_words.append(word)  # Keep original if not confident
            else:
                corrected_words.append(word)  # Keep original if no suggestions

        corrected_sentences.append(" ".join(corrected_words))

    return " ".join(corrected_sentences)


def extract_keywords_and_phrases(text, context=None):
    # Combine current text with context for better understanding
    full_text = text
    if context:
        # Add recent context but with less weight
        full_text = text + " " + " ".join(context[-3:])

    # Process with spaCy
    doc = nlp(full_text.lower())

    # Get named entities
    entities = [ent.text for ent in doc.ents]

    # Extract noun phrases
    noun_phrases = [chunk.text for chunk in doc.noun_chunks]

    # Extract subject-verb-object patterns
    svo_patterns = []
    for sent in doc.sents:
        for token in sent:
            # Find verbs
            if token.pos_ == "VERB":
                # Find subject
                subj = [w for w in token.children if w.dep_ in ["nsubj", "nsubjpass"]]
                # Find object
                obj = [w for w in token.children if w.dep_ in ["dobj", "pobj"]]

                if subj and obj:
                    svo = f"{subj[0].text} {token.text} {obj[0].text}"
                    svo_patterns.append(svo)

    # Extract nouns, proper nouns, and important adjectives
    important_words = [
        token.text for token in doc
        if (token.pos_ in ["NOUN", "PROPN", "ADJ"] and
            token.text.lower() not in STOP_WORDS and
            len(token.text) > 2)
    ]

    # Extract keywords using YAKE
    yake_keywords = [kw[0] for kw in yake_extractor.extract_keywords(text)]

    # Lemmatize words for better matching
    lemmatized_words = [lemmatizer.lemmatize(word) for word in important_words]

    # Combine all keywords and remove duplicates
    all_keywords = list(set(entities + important_words + yake_keywords + lemmatized_words))

    # Extract the most relevant phrases
    all_phrases = list(set(noun_phrases + svo_patterns + yake_keywords))

    # Sort by relevance (length as a simple heuristic)
    all_keywords.sort(key=len, reverse=True)
    all_phrases.sort(key=len, reverse=True)

    return all_keywords[:10], all_phrases[:5]  # Limit to most relevant


def get_chatbot_response(keywords, phrases, context=None):
    try:
        # First try matching complete phrases for more accurate responses
        for phrase in phrases:
            phrase_matches = ChatbotResponse.objects.filter(keyword__icontains=phrase)
            if phrase_matches.exists():
                response = phrase_matches.first().response
                if response.startswith("http"):
                    return f'Click here: <a href="{response}" target="_blank">{response}</a>'
                return response

        # Track matched keywords for weighted selection
        matched_responses = {}

        # Try each keyword and count matches
        for keyword in keywords:
            if len(keyword) < 3:  # Skip very short keywords
                continue

            queries = ChatbotResponse.objects.filter(
                Q(keyword__icontains=keyword) |
                Q(alternate_keywords__icontains=keyword)
            )

            for query in queries:
                if query.response.startswith("http"):
                    return f'Click here: <a href="{query.response}" target="_blank">{query.response}</a>'

                # Count this match (weighted by position in keywords list)
                if query.response in matched_responses:
                    matched_responses[query.response] += 1
                else:
                    matched_responses[query.response] = 1

        # If we have matches, return the one with highest count
        if matched_responses:
            best_response = max(matched_responses.items(), key=lambda x: x[1])[0]
            return best_response

        # If no matches found through keywords, try context-based matching
        if context:
            # Create a combined context string from recent messages
            context_text = " ".join(context[-3:])
            context_doc = nlp(context_text.lower())

            # Extract key topics from context
            context_topics = [
                token.text for token in context_doc
                if token.pos_ in ["NOUN", "PROPN"] and token.text.lower() not in STOP_WORDS
            ]

            # Search for these topics
            for topic in context_topics:
                if len(topic) < 3:  # Skip very short topics
                    continue

                context_matches = ChatbotResponse.objects.filter(
                    Q(keyword__icontains=topic) |
                    Q(alternate_keywords__icontains=topic)
                )

                if context_matches.exists():
                    return context_matches.first().response

        # Fallback to a random appropriate response
        return random.choice(FALLBACK_RESPONSES)

    except Exception as e:
        print(f"Error while querying the database: {e}")
        return random.choice(ERROR_RESPONSES)


def personalize_response(response, user_name):
    # Add user name occasionally (30% chance)
    if user_name and random.random() < 0.3:
        name_markers = [
            f"{user_name}, ",
            f"Hi {user_name}, ",
            f"Well {user_name}, "
        ]
        response = random.choice(name_markers) + response

    # Add conversation continuers occasionally (20% chance)
    if random.random() < 0.2 and not response.endswith("?"):
        continuers = [
            " Is there anything else you'd like to know?",
            " Can I help you with anything else?",
            " Do you have any other questions?",
            " What else would you like to know about our college?"
        ]
        response += random.choice(continuers)

    # Add thinking pauses or fillers occasionally (15% chance)
    if random.random() < 0.15 and len(response) > 30:
        fillers = [
            "Let me see... ",
            "From what I know, ",
            "I believe ",
            "According to our information, "
        ]
        response = random.choice(fillers) + response

    return response


def store_chat_log(session_id, user_name, user_query, bot_response):
    """Stores the conversation logs in the database."""
    try:
        ChatLog.objects.create(
            session_id=session_id,
            user_name=user_name,
            user_query=user_query,
            bot_response=bot_response
        )
        print("Chat log stored successfully!")
    except Exception as e:
        print(f"Error storing chat log: {e}")


def index(request):
    courses = Course.objects.all()
    contact = Contact.objects.all()
    notices = Admission.objects.all()
    fees = Fees.objects.all()
    total_fee = sum([fee.sem1 + fee.sem2 + fee.sem3 + fee.sem4 + fee.sem5 + fee.sem6 for fee in fees])

    return render(request, 'index.html', {'courses': courses, 'total_fee': total_fee, 'contact': contact, 'notices': notices})


def signup(request):
    if request.method == "POST":
        form = ApplicantRegistrationForm(request.POST)
        if form.is_valid():
            full_name = form.cleaned_data["full_name"]
            email = form.cleaned_data["email"]
            phone_number = form.cleaned_data["phone_number"]
            date_of_birth = form.cleaned_data["date_of_birth"]
            gender = form.cleaned_data["gender"]
            password = form.cleaned_data["password"]

            # Check if email already exists
            if Applicant.objects.filter(email=email).exists():
                form.add_error("email", "This email is already registered.")
                return render(request, "signup.html", {"form": form})

            hashed_password = make_password(password)

            try:
                suser = Applicant.objects.create(
                    full_name=full_name,
                    email=email,
                    phone_number=phone_number,
                    date_of_birth=date_of_birth,
                    gender=gender,
                    password=hashed_password
                )
            except Exception as e:
                form.add_error(None, "An error occurred while creating your account. Please try again.")
                return render(request, "signup.html", {"form": form})

            # Create session
            request.session["suser_id"] = suser.id
            request.session["suser_name"] = suser.full_name
            request.session["is_authenticated"] = True
            request.session.modified = True  # Ensure session is saved

            return redirect("application_home")  # Redirect to home page after signup
        else:
            return render(request, "signup.html", {"form": form})
    else:
        form = ApplicantRegistrationForm()

    return render(request, "signup.html", {"form": form})


def login(request):
    if request.method == "POST":
        form = ApplicantLoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data["email"]
            password = form.cleaned_data["password"]

            try:
                suser = Applicant.objects.get(email=email)
            except Applicant.DoesNotExist:
                form.add_error("email", "Invalid email or password.")
                return render(request, "login.html", {"form": form})

            if not check_password(password, suser.password):
                form.add_error("password", "Invalid email or password.")
                return render(request, "login.html", {"form": form})

            # Create session
            request.session["suser_id"] = suser.id
            request.session["suser_name"] = suser.full_name
            request.session["is_authenticated"] = True
            request.session.modified = True  # Ensure session is saved

            print(f"Session Data: {request.session.items()}")
            return redirect("application_home")  # Redirect to home page after login
    else:
        form = ApplicantLoginForm()

    return render(request, "login.html", {"form": form})

def logout(request):
    request.session.flush()  # Clear session data
    return redirect("login")


def application(request):
    print(f"Session Data: {request.session.items()}")
    if request.method == "POST":
        form = EntranceExamRegistrationForm(request.POST, request.FILES)  # Note the request.FILES parameter
        if form.is_valid():
            form_data = form.cleaned_data

            # Fetch user ID from session
            user_id = request.session.get('suser_id')
            if not user_id:
                return render(request, "login.html", {"form": form, "error": "User not logged in."})

            # Check if an application already exists for this applicant_id
            if Applications.objects.filter(applicant_id=user_id).exists():
                return render(request, "application.html",
                              {"form": form, "error": "You have already submitted an application."})

            # Create and save application
            application = Applications.objects.create(
                applicant_id=user_id,
                full_name=form_data['full_name'],
                gender=form_data['gender'],
                date_of_birth=form_data['date_of_birth'],
                mother_tongue=form_data['mother_tongue'],
                nationality=form_data['nationality'],
                phone_number=form_data['phone_number'],
                email=form_data['email'],
                fathers_guardians_mobile_number=form_data['fathers_guardians_mobile_number'],
                admission_for=form_data['admission_for'],
                academic_year=form_data['academic_year'],
                priority_1=form_data['priority_1'],
                priority_2=form_data['priority_2'],
                priority_3=form_data['priority_3'],
                admission_quota=form_data['admission_quota'],
                tenth_board=form_data['tenth_board'],
                tenth_register_number=form_data['tenth_register_number'],
                tenth_year_of_passing=form_data['tenth_year_of_passing'],
                tenth_total_score=form_data['tenth_total_score'],
                sslc_percentage=form_data['sslc_percentage'],
                higher_secondary_school_name=form_data['higher_secondary_school_name'],
                higher_secondary_board=form_data['higher_secondary_board'],
                higher_secondary_year_of_passing=form_data['higher_secondary_year_of_passing'],
                physics_percentage=form_data.get('physics_percentage'),
                chemistry_percentage=form_data.get('chemistry_percentage'),
                maths_percentage=form_data.get('maths_percentage'),
                computer_science_percentage=form_data.get('computer_science_percentage'),
                total_percentage=form_data['total_percentage'],
                # Handle file uploads
                applicant_photo=form_data.get('applicant_photo'),
                twelfth_mark_list=form_data.get('twelfth_mark_list'),
                tenth_mark_list=form_data.get('tenth_mark_list')
            )

            return redirect("application_home")
        else:
            return render(request, "application.html", {"form": form})
    else:
        form = EntranceExamRegistrationForm()
    return render(request, "application.html", {"form": form})

def application_status(request):
    print(f"Session Data: {request.session.items()}")
    user_id = request.session.get("suser_id")  # Get user_id from session
    if not user_id:
        return redirect("login")
    else:
        applications = Applications.objects.filter(applicant_id=user_id)  # Filter by applicant_id

        return render(request, "application_status.html", {"applications": applications})


def application_home(request):
    print(f"Session Data: {request.session.items()}")
    user_id = request.session.get("suser_id")  # Get user_id from session
    if not user_id:
        return redirect("login")
    else:

        applications = Applications.objects.filter(applicant_id=user_id)  # Filter by applicant_id
        application_exists = Applications.objects.filter(applicant_id=user_id).exists()

        applicants = Applicant.objects.get(id=user_id)
        if applicants.notification:
            notification = True
        else:
            notification = False

        if application_exists:
            applied = True
        else:
            applied = False

        reminder = applicants.notification

        return render(request, "application_home.html", {"applications": applications, "applied": applied, "notification": notification, "reminder": reminder})



def managementSignUp(request):
    if request.method == "POST":
        form = ManagementSignUpForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.password = make_password(user.password)  # Hash password before saving
            user.save()
            messages.success(request, "Account created successfully! Please log in.")
            return redirect("managementLogin")
    else:
        form = ManagementSignUpForm()
    return render(request, "managementSignUp.html", {"form": form})


def managementLogin(request):
    if request.method == "POST":
        form = ManagementLoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data["email"]
            try:
                # Fetch the CollegeManagement object using email
                muser = CollegeManagement.objects.get(email=email)

                # Save user information in session
                request.session["muser_id"] = muser.id
                request.session["muser_name"] = muser.name

                # Debug: Print session data
                print("Session Data:", request.session.items())

                return redirect("analytical_charts")
            except CollegeManagement.DoesNotExist:
                messages.error(request, "User does not exist!")
                return redirect("managementLogin")
    else:
        form = ManagementLoginForm()

    return render(request, "managementLogin.html", {"form": form})


def managementDashboard(request):
    # Retrieve muser_id from session
    muser_id = request.session.get("muser_id")
    print("Session muser_id:", muser_id)  # Debug: Check session value

    if not muser_id:
        messages.error(request, "You must log in first!")
        return redirect("managementLogin")

    try:
        muser = CollegeManagement.objects.get(id=muser_id)
        applications = Applications.objects.all()
        available_courses = Course.objects.all()
    except CollegeManagement.DoesNotExist:
        messages.error(request, "User not found!")
        return redirect("managementLogin")

    return render(request, "managementDashboard.html",
                  {"muser": muser, "applications": applications, "available_courses": available_courses})


@require_http_methods(["POST"])
def update_status(request):
    try:
        data = json.loads(request.body)
        application_id = data.get('application_id')
        new_status = data.get('status')

        # Get the application
        application = Applications.objects.get(id=application_id)
        applicantID = application.applicant_id
        applicant = Applicant.objects.get(id=applicantID)

        if new_status == 'accepted' or 'Accepted':
            applicant.notification = "Your application has been approved"
        elif new_status == 'rejectd'or 'Rejected':
            applicant.notification = "Your application has been rejected"
        # Update the status
        application.status = new_status
        applicant.save()
        application.save()

        return JsonResponse({
            'success': True,
            'message': 'Status updated successfully'
        })
    except Applications.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Application not found'
        }, status=404)
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': str(e)
        }, status=500)


@csrf_exempt
@require_POST
def update_course(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            application_id = data.get('application_id')
            new_course = data.get('allotted_course')
            print("Course =", new_course)

            application = Applications.objects.get(id=application_id)
            applicantID = application.applicant_id
            applicant = Applicant.objects.get(id=applicantID)
            if new_course:
                seats = Course.objects.get(tag=new_course)
                seats.seats -= 1
                seats.save()
            applicant.notification = "The course allotted for you is " + new_course
            applicant.save()
            application.alloted_course = new_course
            application.save()


            messages.success(request, f'Course updated successfully to {new_course}')
            return JsonResponse({'success': True})
        except Applications.DoesNotExist:
            messages.error(request, 'Application not found')
            return JsonResponse({'success': False, 'error': 'Application not found'})
        except Exception as e:
            messages.error(request, 'An error occurred while updating course')
            return JsonResponse({'success': False, 'error': str(e)})

    return JsonResponse({'success': False, 'error': 'Invalid request method'})


def managementLogout(request):
    request.session.flush()  # Clear session data
    messages.success(request, "Logged out successfully!")
    return redirect("managementLogin")


def application_details(request, application_id):
    application = Applications.objects.get(id=application_id)
    return render(request, 'application_details.html', {'application': application})


def search_applications(request):
    """API endpoint for searching applications"""
    search_query = request.GET.get('search', '').strip()
    status_filter = request.GET.get('status', '')
    course_filter = request.GET.get('course', '')
    minMark12th = request.GET.get('twelfth_min_marks', '')
    maxMark12th = request.GET.get('twelfth_max_marks', '')
    minMark10th = request.GET.get('tenth_min_marks', '')
    maxMark10th = request.GET.get('tenth_max_marks', '')
    page = request.GET.get('page', 1)

    queryset = Applications.objects.all()

    # Apply search filter
    if search_query:
        queryset = queryset.filter(
            Q(application_number__icontains=search_query) |
            Q(full_name__icontains=search_query) |
            Q(email__icontains=search_query) |
            Q(phone_number__icontains=search_query) |
            Q(tenth_total_score__icontains=search_query) |
            Q(sslc_percentage__icontains=search_query) |
            Q(total_percentage__icontains=search_query) |
            Q(alloted_course__icontains=search_query) |
            Q(priority_1__icontains=search_query) |
            Q(priority_2__icontains=search_query) |
            Q(priority_3__icontains=search_query)
        )

    # Apply status filter
    if status_filter:
        queryset = queryset.filter(status=status_filter)

    # Apply course filter
    if course_filter:
        queryset = queryset.filter(
            Q(alloted_course=course_filter) |
            Q(priority_1=course_filter) |
            Q(priority_2=course_filter) |
            Q(priority_3=course_filter)
        )

    # Apply 12th marks range filter
    if minMark12th and maxMark12th:
        try:
            minMark12th = float(minMark12th)
            maxMark12th = float(maxMark12th)
            queryset = queryset.filter(total_percentage__gte=minMark12th, total_percentage__lte=maxMark12th)
        except ValueError:
            pass  # Ignore invalid numbers

    # Apply 10th marks range filter (SSLC percentage)
    if minMark10th and maxMark10th:
        try:
            minMark10th = float(minMark10th)
            maxMark10th = float(maxMark10th)
            queryset = queryset.filter(sslc_percentage__gte=minMark10th, sslc_percentage__lte=maxMark10th)
        except ValueError:
            pass  # Ignore invalid numbers

    # Paginate results
    paginator = Paginator(queryset, 12)  # Show 12 applications per page
    applications = paginator.get_page(page)

    # Prepare response data
    results = [{
        'id': app.id,
        'application_number': app.application_number,
        'full_name': app.full_name,
        'email': app.email,
        'phone_number': app.phone_number,
        'tenth_total_score': app.tenth_total_score,
        'sslc_percentage': app.sslc_percentage,
        'total_percentage': app.total_percentage,
        'status': app.status,
        'alloted_course': app.alloted_course,
        'priority_1': app.priority_1,
        'priority_2': app.priority_2,
        'priority_3': app.priority_3,
    } for app in applications]

    return JsonResponse({
        'results': results,
        'total_pages': paginator.num_pages,
        'current_page': int(page),
        'total_results': paginator.count
    })


class ApplicationForm(ModelForm):
    class Meta:
        model = Applications
        fields = '__all__'  # Include all fields in the form


def editApplication(request, id):
    application = get_object_or_404(Applications, id=id)

    if request.method == 'POST':
        form = ApplicationForm(request.POST, request.FILES, instance=application)
        if form.is_valid():
            form.save()
            messages.success(request, 'Application updated successfully!')
            return redirect('application_status')  # Update this to your actual redirect URL
        else:
            messages.error(request, 'There were errors in the form.')
    else:
        form = ApplicationForm(instance=application)

    return render(request, 'editApplication.html', {'form': form, 'application': application})


import json
from django.shortcuts import render, redirect
from django.contrib import messages
from django.utils import timezone
from django.db.models import Count, Q
from .models import CollegeManagement, Applicant, Applications, ChatLog


def analytical_charts(request):
    """View function to render the analytical dashboard with various statistics and charts."""

    # Retrieve user ID from session
    muser_id = request.session.get("muser_id")

    # Authenticate user
    try:
        muser = CollegeManagement.objects.get(id=muser_id)
    except CollegeManagement.DoesNotExist:
        messages.error(request, "User not found!")
        return redirect("managementLogin")

    # Retrieve total applicants count
    total_applicants = Applicant.objects.count()

    # Count applicants with at least one application
    applicants_with_applications_count = Applicant.objects.filter(
        id__in=Applications.objects.values_list("applicant_id", flat=True)
    ).distinct().count()

    # Calculate drop-off applicants (applicants who never applied)
    drop_off_applicants_count = total_applicants - applicants_with_applications_count

    print(f"Total Applicants: {total_applicants}")
    print(f"Applicants with Applications: {applicants_with_applications_count}")
    print(f"Drop-off Applicants: {drop_off_applicants_count}")

    # Retrieve filter parameters from the request
    date_range = request.GET.get("date_range", "Last 30 days")
    course_filter = request.GET.get("course", "All Courses")
    status_filter = request.GET.get("status", "All Statuses")

    # Base querysets
    applicants_query = Applicant.objects.all()
    applications_query = Applications.objects.all()
    chatlog_query = ChatLog.objects.all()

    # Date filter mapping
    date_filters = {
        "Today": timezone.now().date(),
        "Last 30 days": timezone.now() - timezone.timedelta(days=30),
        "Last quarter": timezone.now() - timezone.timedelta(days=90),
        "Last year": timezone.now() - timezone.timedelta(days=365),
    }

    # Apply date filter if applicable
    if date_range in date_filters:
        date_cutoff = date_filters[date_range]
        applicants_query = applicants_query.filter(created_at__gte=date_cutoff)
        applications_query = applications_query.filter(created_at__gte=date_cutoff)
        chatlog_query = chatlog_query.filter(timestamp__gte=date_cutoff)

    # Apply course filter if selected
    if course_filter != "All Courses":
        applications_query = applications_query.filter(
            Q(priority_1=course_filter) |
            Q(priority_2=course_filter) |
            Q(priority_3=course_filter)
        )

    # Apply status filter if selected
    if status_filter != "All Statuses":
        applications_query = applications_query.filter(status__iexact=status_filter)

    # KPI Calculations
    filtered_applicants_count = applicants_query.count()
    approved_count = applications_query.filter(status__iexact="Approved").count()
    total_applications = applications_query.count()
    approval_rate = (approved_count / total_applications * 100) if total_applications else 0

    chatbot_interactions = chatlog_query.count()

    # Data Aggregation for Charts
    gender_counts = applicants_query.values("gender").annotate(count=Count("gender"))
    status_counts = applications_query.values("status").annotate(count=Count("status"))
    course_preference_counts = applications_query.values("priority_1").annotate(count=Count("priority_1"))
    top_queries = chatlog_query.values("user_query").annotate(count=Count("user_query")).order_by("-count")[:5]

    # Trend Placeholders (Replace with actual calculations later)
    processing_time_trend = abs(-0.8)  # Placeholder value
    print("totaluser ",filtered_applicants_count)
    # Context Data for Template
    context = {
        "muser": muser,
        "total_applicants": total_applicants,
        "total_applications": total_applications,
        "approval_rate": f"{approval_rate:.1f}",
        "chatbot_interactions": chatbot_interactions,
        "processing_time_trend": processing_time_trend,
        "applicants_trend": 12.4,  # Placeholder
        "approval_rate_trend": 3.2,  # Placeholder
        "chatbot_trend": 27.3,  # Placeholder

        # JSON Data for Charts
        "gender_data_json": json.dumps({
            "labels": [item["gender"] for item in gender_counts],
            "datasets": [{
                "label": "Applicants by Gender",
                "data": [item["count"] for item in gender_counts],
                "backgroundColor": ["#0078D4", "#E3008C", "#00B294"],
                "borderWidth": 1,
            }],
        }),
        "status_data_json": json.dumps({
            "labels": [item["status"].capitalize() for item in status_counts],
            "datasets": [{
                "label": "Admission Status",
                "data": [item["count"] for item in status_counts],
                "backgroundColor": ["#107C10", "#FFB900", "#D13438"],
                "borderWidth": 1,
            }],
        }),
        "course_data_json": json.dumps({
            "labels": [item["priority_1"] for item in course_preference_counts],
            "datasets": [{
                "label": "Course Preferences",
                "data": [item["count"] for item in course_preference_counts],
                "backgroundColor": ["#0078D4", "#E3008C", "#FFB900", "#107C10", "#8764B8"],
                "borderWidth": 1,
            }],
        }),
        "chatbot_data_json": json.dumps({
            "labels": [item["user_query"] for item in top_queries],
            "datasets": [{
                "label": "Query Frequency",
                "data": [item["count"] for item in top_queries],
                "backgroundColor": ["#0078D4", "#E3008C", "#FFB900", "#107C10", "#8764B8"],
                "borderWidth": 1,
            }],
        }),

        # Drop-off Applicants Data
        "drop_off_applicants": drop_off_applicants_count,
        "applicants_with_applications" : applicants_with_applications_count,
    }

    return render(request, "analytical_charts.html", context)



# Refresh data view (optional)
@csrf_exempt
# Helper function for AAD token (used by refresh_report_data)
def generate_aad_token():
    """Helper function to get an Azure AD token"""
    try:
        aad_token_url = f"https://login.microsoftonline.com/{settings.TENANT_ID}/oauth2/token"
        aad_data = {
            'grant_type': 'client_credentials',
            'client_id': settings.CLIENT_ID,
            'client_secret': settings.CLIENT_SECRET,
            'resource': 'https://analysis.windows.net/powerbi/api'
        }

        response = requests.post(aad_token_url, data=aad_data)
        aad_response = response.json()

        if 'access_token' in aad_response:
            return aad_response['access_token']
        return None
    except Exception:
        return None

def chatLog(request):
    # muser = none
    # Retrieve user ID from session
    muser_id = request.session.get("muser_id")

    # Authenticate user
    try:
        muser = CollegeManagement.objects.get(id=muser_id)
    except CollegeManagement.DoesNotExist:
        messages.error(request, "User not found!")
        # return redirect("managementLogin")

    chat_logs = ChatLog.objects.all().order_by('-timestamp')  # Fetch all logs, latest first

    context={
        'chat_logs': chat_logs,
        'muser': muser
    }

    return render(request, 'chatLog.html', context)


def dropOffList(request):
    # Get the authenticated user first
    muser_id = request.session.get("muser_id")

    try:
        muser = CollegeManagement.objects.get(id=muser_id)
    except CollegeManagement.DoesNotExist:
        messages.error(request, "Authentication required")
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return JsonResponse({'success': False, 'error': 'Authentication required'})
        return redirect('login_url')  # Replace with your login URL

    if request.method == 'POST':
        try:
            # Debug logging
            print("POST data received:", request.POST)

            # Get form data
            selected_applicant_ids = request.POST.get('selectedApplicantIds', '')
            selected_template = request.POST.get('selectedTemplate', '1')

            print(f"Raw selected IDs: {selected_applicant_ids}")

            # Split IDs if they're comma-separated
            if ',' in selected_applicant_ids:
                selected_applicant_ids = selected_applicant_ids.split(',')
            else:
                selected_applicant_ids = [selected_applicant_ids]

            # Filter out empty strings
            selected_applicant_ids = [id.strip() for id in selected_applicant_ids if id.strip()]

            print(f"Processed selected IDs: {selected_applicant_ids}")

            if not selected_applicant_ids:
                return JsonResponse({'success': False, 'error': 'No applicants selected'})

            # Get the reminder template
            try:
                reminder = Reminder.objects.get(reminderId=selected_template)
                print(f"Found reminder template: {reminder.reminderId} - {reminder.reminder[:50]}...")
            except Reminder.DoesNotExist:
                print(f"Reminder template {selected_template} not found")
                return JsonResponse({'success': False, 'error': f'Reminder template {selected_template} not found'})

            success_count = 0
            failed_ids = []

            # Process each applicant
            for id in selected_applicant_ids:
                try:
                    print(f"Processing applicant ID: {id}")
                    applicant = Applicant.objects.get(id=id)

                    # Check if notification field exists
                    if hasattr(applicant, 'notification'):
                        applicant.notification = reminder.reminder
                        applicant.save()
                        success_count += 1
                        print(f"Successfully updated applicant {id}")
                    else:
                        print(f"Applicant {id} has no notification field")
                        failed_ids.append(f"{id} (no notification field)")
                except Applicant.DoesNotExist:
                    print(f"Applicant {id} does not exist")
                    failed_ids.append(f"{id} (not found)")
                except Exception as e:
                    print(f"Error updating applicant {id}: {str(e)}")
                    failed_ids.append(f"{id} ({str(e)})")

            result = {
                'success': success_count > 0,
                'message': f"Updated {success_count} applicants",
                'failed_count': len(failed_ids),
                'failed_ids': failed_ids
            }

            if not result['success']:
                result['error'] = f"Failed to update any applicants. Errors: {', '.join(failed_ids)}"

            print("Returning response:", result)
            return JsonResponse(result)

        except Exception as e:
            print(f"Unexpected error in view: {str(e)}")
            import traceback
            traceback.print_exc()
            return JsonResponse({'success': False, 'error': f'Server error: {str(e)}'})

    # For GET requests - show the list of applicants
    applicants = Applicant.objects.exclude(id__in=Applications.objects.values_list('applicant_id', flat=True))
    applicant_list = list(applicants.values('id', 'full_name', 'email', 'phone_number', 'date_of_birth', 'gender'))

    context = {
        'applicants_without_application': applicant_list,
        'muser': muser
    }

    return render(request, 'dropOffList.html', context)

def viewApplicants(request):
    applicants = Applicant.objects.all()
    return render(request, 'viewApplicants.html',{'applicants': applicants})