from django import forms
from .models import CollegeManagement, Applications
from django.contrib.auth.hashers import check_password

class EntranceExamRegistrationForm(forms.Form):
    # Personal Details
    full_name = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'placeholder': 'Full Name (as per SSLC Book)'}),
    )
    gender_choices = [('male', 'Male'), ('female', 'Female'), ('other', 'Other')]
    gender = forms.ChoiceField(choices=gender_choices, widget=forms.RadioSelect())
    date_of_birth = forms.DateField(widget=forms.DateInput(attrs={'type': 'date'}))

    mother_tongue_choices = [
        ('malayalam', 'Malayalam'), ('hindi', 'Hindi'), ('english', 'English'),
        ('bengali', 'Bengali'), ('marathi', 'Marathi'), ('telugu', 'Telugu'),
        ('tamil', 'Tamil'), ('gujarati', 'Gujarati'), ('urdu', 'Urdu'),
        ('kannada', 'Kannada'), ('odia', 'Odia'), ('punjabi', 'Punjabi'),
        ('assamese', 'Assamese'), ('maithili', 'Maithili'), ('sanskrit', 'Sanskrit'),
        ('konkani', 'Konkani'), ('tulu', 'Tulu'),
    ]
    mother_tongue = forms.ChoiceField(choices=mother_tongue_choices)
    nationality = forms.CharField(
        max_length=50,
        widget=forms.TextInput(attrs={'placeholder': 'Nationality'}),
    )
    phone_number = forms.CharField(
        max_length=15,
        widget=forms.TextInput(attrs={'placeholder': 'Phone Number'}),
    )
    email = forms.EmailField(
        max_length=100,
        widget=forms.EmailInput(attrs={'placeholder': 'Email'}),
    )
    fathers_guardians_mobile_number = forms.CharField(
        max_length=15,
        widget=forms.TextInput(attrs={'placeholder': "Father's / Guardian's Mobile Number"}),
    )

    # Admission Details
    admission_for = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'placeholder': 'Admission For'}),
    )
    academic_year = forms.CharField(
        max_length=9,
        widget=forms.TextInput(attrs={'placeholder': 'Academic Year (e.g., 2025-2026)'}),
    )

    course_choices = [
        ('bca', 'Bachelor of Science in Computer Science'),
        ('ba_eng', 'Bachelor of Arts in English Literature'),
        ('bcom', 'Bachelor of Commerce'),
        ('bba', 'Bachelor of Business Administration'),
        ('bsc_phy', 'Bachelor of Science in Physics'),
    ]
    priority_1 = forms.ChoiceField(choices=course_choices)
    priority_2 = forms.ChoiceField(choices=course_choices)
    priority_3 = forms.ChoiceField(choices=course_choices)

    admission_quota_choices = [('management', 'Management Quota'), ('nri', 'NRI')]
    admission_quota = forms.ChoiceField(
        choices=admission_quota_choices,
        widget=forms.RadioSelect(),
    )

    # 10th Exam Details
    board_choices = [
        ('hse_kerala', 'HSE KERALA'), ('cbse', 'CBSE'),
        ('icse', 'ICSE'), ('others', 'OTHERS'),
    ]
    tenth_board = forms.ChoiceField(choices=board_choices)
    tenth_register_number = forms.CharField(
        max_length=50,
        widget=forms.TextInput(attrs={'placeholder': 'Register Number'}),
    )
    tenth_year_of_passing = forms.ChoiceField(
        choices=[(str(year), str(year)) for year in range(2025, 1999, -1)]
    )
    tenth_total_score = forms.IntegerField(
        widget=forms.NumberInput(attrs={'placeholder': 'Total Score'}),
    )
    sslc_percentage = forms.FloatField(
        widget=forms.NumberInput(attrs={'placeholder': 'SSLC Percentage'}),
    )

    # Higher Secondary School Details
    higher_secondary_school_name = forms.CharField(
        max_length=200,
        widget=forms.TextInput(attrs={'placeholder': 'School Name'}),
    )
    higher_secondary_board = forms.ChoiceField(choices=board_choices)
    higher_secondary_year_of_passing = forms.ChoiceField(
        choices=[(str(year), str(year)) for year in range(2025, 1999, -1)]
    )

    # Higher Secondary Percentage Obtained
    physics_percentage = forms.FloatField(
        required=False,
        widget=forms.NumberInput(attrs={'placeholder': 'Physics Percentage'}),
    )
    chemistry_percentage = forms.FloatField(
        required=False,
        widget=forms.NumberInput(attrs={'placeholder': 'Chemistry Percentage'}),
    )
    maths_percentage = forms.FloatField(
        required=False,
        widget=forms.NumberInput(attrs={'placeholder': 'Mathematics Percentage'}),
    )
    computer_science_percentage = forms.FloatField(
        required=False,
        widget=forms.NumberInput(attrs={'placeholder': 'Computer Science Percentage'}),
    )
    total_percentage = forms.FloatField(
        required=True,
        widget=forms.NumberInput(attrs={'placeholder': 'Overall Percentage'}),
    )
    applicant_photo = forms.ImageField(
        label="Applicant Photo",
        required=False,
        widget=forms.FileInput(attrs={'class': 'form-control'})
    )
    twelfth_mark_list = forms.ImageField(
        label="12th Mark List",
        required=False,
        widget=forms.FileInput(attrs={'class': 'form-control'})
    )
    tenth_mark_list = forms.ImageField(
        label="10th Mark List",
        required=False,
        widget=forms.FileInput(attrs={'class': 'form-control'})
    )


class ApplicantRegistrationForm(forms.Form):
    full_name = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={'placeholder': 'Full Name'}),
    )
    email = forms.EmailField(
        max_length=100,
        widget=forms.EmailInput(attrs={'placeholder': 'Email'}),
    )
    phone_number = forms.CharField(
        max_length=10,
        widget=forms.TextInput(attrs={'placeholder': 'Phone Number'}),
    )
    date_of_birth = forms.DateField(
        widget=forms.DateInput(attrs={'type': 'date'}),
    )

    gender_choices = [('male', 'Male'), ('female', 'Female'), ('other', 'Other')]
    gender = forms.ChoiceField(choices=gender_choices, widget=forms.RadioSelect())

    password = forms.CharField(
        widget=forms.PasswordInput(attrs={'placeholder': 'Password'}),
    )
    confirm_password = forms.CharField(
        widget=forms.PasswordInput(attrs={'placeholder': 'Confirm Password'}),
    )

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")
        if password and confirm_password and password != confirm_password:
            self.add_error('confirm_password', "Passwords do not match.")
        return cleaned_data

class ApplicantLoginForm(forms.Form):
    email = forms.EmailField(
        max_length=100,
        widget=forms.EmailInput(attrs={'placeholder': 'Email'}),
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={'placeholder': 'Password'}),
    )

class ManagementSignUpForm(forms.ModelForm):
    confirm_password = forms.CharField(widget=forms.PasswordInput)

    class Meta:
        model = CollegeManagement
        fields = ['name', 'email', 'phone_number', 'password']
        widgets = {
            'password': forms.PasswordInput()
        }

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")

        if password and confirm_password and password != confirm_password:
            self.add_error("confirm_password", "Passwords do not match!")

        return cleaned_data

class ManagementLoginForm(forms.Form):
    email = forms.EmailField()
    password = forms.CharField(widget=forms.PasswordInput)

    def clean(self):
        cleaned_data = super().clean()
        email = cleaned_data.get("email")
        password = cleaned_data.get("password")

        if email and password:
            try:
                user = CollegeManagement.objects.get(email=email)
                if not check_password(password, user.password):
                    self.add_error("password", "Incorrect password!")
            except CollegeManagement.DoesNotExist:
                self.add_error("email", "User does not exist!")

        return cleaned_data

class ApplicationForm(forms.ModelForm):
    class Meta:
        model = Applications
        fields = '__all__'

