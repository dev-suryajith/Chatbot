import uuid
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

class Course(models.Model):
    course = models.CharField(max_length=255)
    name = models.CharField(max_length=10,null=True, blank=True)
    tag = models.CharField(max_length=10,null=True,blank=True)
    description = models.TextField()
    seats = models.IntegerField(null=True, blank=True)

    class Meta:
        db_table = 'Course'

class Admission(models.Model):
    notice = models.TextField(max_length=255)

    class Meta:
        db_table = 'Admission'

class Contact(models.Model):
    address = models.TextField()
    phone = models.CharField(max_length=15)
    email = models.EmailField()

    class Meta:
        db_table = 'Contact'

class Fees(models.Model):
    sem1 = models.IntegerField()
    sem2 = models.IntegerField()
    sem3 = models.IntegerField()
    sem4 = models.IntegerField()
    sem5 = models.IntegerField()
    sem6 = models.IntegerField()

    class Meta:
        db_table = 'Fees'

class ChatbotResponse(models.Model):
    keyword = models.CharField(max_length=255)
    response = models.TextField(10000)

    class Meta:
        db_table = 'ChatbotResponse'

class ChatLog(models.Model):
    session_id = models.CharField(max_length=255, default=uuid.uuid4, editable=False)  # Auto-generate session ID
    user_name = models.CharField(max_length=100, null=True, blank=True)
    user_query = models.TextField()
    bot_response = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"ChatLog {self.session_id} - {self.timestamp}"
    class Meta:
        db_table = 'chatLog'

class chatBot_querries(models.Model):
    query = models.CharField(max_length=555)

    class Meta:
        db_table = 'chatbot_querries'

from django.db import models
import uuid

class Applications(models.Model):
    # Personal Details
    applicant_id = models.CharField(max_length=255, null=True, blank=True, unique=True)
    application_number = models.CharField(max_length=255, unique=True, null=True, blank=True)
    alloted_course = models.CharField(max_length=255, null=True, blank=True)
    status_choices = [
        ('pending', 'Pending'),
        ('accepted', 'Accepted'),
        ('rejected', 'Rejected'),
    ]
    status = models.CharField(max_length=10, choices=status_choices, default='pending', null=True, blank=True,)
    full_name = models.CharField(max_length=100)
    gender_choices = [('male', 'Male'), ('female', 'Female'), ('other', 'Other')]
    gender = models.CharField(max_length=10, choices=gender_choices)
    date_of_birth = models.DateField()

    mother_tongue_choices = [
        ('malayalam', 'Malayalam'), ('hindi', 'Hindi'), ('english', 'English'),
        ('bengali', 'Bengali'), ('marathi', 'Marathi'), ('telugu', 'Telugu'),
        ('tamil', 'Tamil'), ('gujarati', 'Gujarati'), ('urdu', 'Urdu'),
        ('kannada', 'Kannada'), ('odia', 'Odia'), ('punjabi', 'Punjabi'),
        ('assamese', 'Assamese'), ('maithili', 'Maithili'), ('sanskrit', 'Sanskrit'),
        ('konkani', 'Konkani'), ('tulu', 'Tulu'),
    ]
    mother_tongue = models.CharField(max_length=20, choices=mother_tongue_choices)
    nationality = models.CharField(max_length=50)
    phone_number = models.CharField(max_length=15)
    email = models.EmailField(max_length=100)
    fathers_guardians_mobile_number = models.CharField(max_length=15)

    # Admission Details
    admission_for = models.CharField(max_length=100)
    academic_year = models.CharField(max_length=9)

    course_choices = [
        ('bca', 'Bachelor of Science in Computer Science'),
        ('ba_eng', 'Bachelor of Arts in English Literature'),
        ('bcom', 'Bachelor of Commerce'),
        ('bba', 'Bachelor of Business Administration'),
        ('bsc_phy', 'Bachelor of Science in Physics'),
    ]
    priority_1 = models.CharField(max_length=20, choices=course_choices)
    priority_2 = models.CharField(max_length=20, choices=course_choices)
    priority_3 = models.CharField(max_length=20, choices=course_choices)

    admission_quota_choices = [('management', 'Management Quota'), ('nri', 'NRI')]
    admission_quota = models.CharField(max_length=20, choices=admission_quota_choices)

    # 10th Exam Details
    board_choices = [
        ('hse_kerala', 'HSE KERALA'), ('cbse', 'CBSE'),
        ('icse', 'ICSE'), ('others', 'OTHERS'),
    ]
    tenth_board = models.CharField(max_length=20, choices=board_choices)
    tenth_register_number = models.CharField(max_length=50)
    tenth_year_of_passing = models.CharField(max_length=4)
    tenth_total_score = models.IntegerField()
    sslc_percentage = models.FloatField()

    # Higher Secondary School Details
    higher_secondary_school_name = models.CharField(max_length=200)
    higher_secondary_board = models.CharField(max_length=20, choices=board_choices)
    higher_secondary_year_of_passing = models.CharField(max_length=4)

    # Higher Secondary Percentage Obtained
    physics_percentage = models.FloatField(null=True, blank=True)
    chemistry_percentage = models.FloatField(null=True, blank=True)
    maths_percentage = models.FloatField(null=True, blank=True)
    computer_science_percentage = models.FloatField(null=True, blank=True)
    total_percentage = models.FloatField()

    #Images
    applicant_photo = models.ImageField(upload_to='applicant_photos/', null=True, blank=True)
    twelfth_mark_list = models.ImageField(upload_to='twelfth_mark_lists/', null=True, blank=True)
    tenth_mark_list = models.ImageField(upload_to='tenth_mark_lists/', null=True, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.application_number:
            self.application_number = f"APP{uuid.uuid4().hex[:10].upper()}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.full_name} ({self.academic_year})"

    class Meta:
        db_table = 'applications'


class Applicant(models.Model):
    GENDER_CHOICES = [
        ('Male', 'Male'),
        ('Female', 'Female'),
        ('Other', 'Other'),
    ]


    full_name = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=15, unique=True)
    date_of_birth = models.DateField()
    gender = models.CharField(max_length=10, choices=GENDER_CHOICES)
    password = models.CharField(max_length=255)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    notification =  models.TextField(null=True,blank=True)

    def __str__(self):
        return self.full_name

    class Meta:
        db_table = 'applicants'

class CollegeManagement(models.Model):
    phone_number = models.CharField(max_length=15, unique=True)
    name = models.CharField(max_length=225, unique=True)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)

    def save(self, *args, **kwargs):
        """Ensure password is hashed before saving."""
        if not self.password.startswith('pbkdf2_sha256$'):
            self.password = make_password(self.password)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'management'

class Reminder(models.Model):
    reminderId = models.IntegerField()
    reminder = models.CharField(max_length=255)

    class Meta:
        db_table = 'reminder'


