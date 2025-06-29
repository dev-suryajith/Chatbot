from django.contrib import admin
from .models import Course, Admission, Contact, Fees, ChatbotResponse, ChatLog, Applications, Applicant, CollegeManagement

# Admin configuration for Course model
class CourseAdmin(admin.ModelAdmin):
    list_display = ('course', 'description', 'seats')
    search_fields = ['course']
    ordering = ['course']

# Admin configuration for Admission model
class AdmissionAdmin(admin.ModelAdmin):
    list_display = ('notice',)
    search_fields = ['notice']

# Admin configuration for Contact model
class ContactAdmin(admin.ModelAdmin):
    list_display = ('address', 'phone', 'email')
    search_fields = ['email', 'phone']

# Admin configuration for Fees model
class FeesAdmin(admin.ModelAdmin):
    list_display = ('sem1', 'sem2', 'sem3', 'sem4', 'sem5', 'sem6')
    search_fields = ['sem1', 'sem2', 'sem3', 'sem4', 'sem5', 'sem6']

# Admin configuration for ChatbotResponse model
class ChatbotResponseAdmin(admin.ModelAdmin):
    list_display = ('keyword', 'response')
    search_fields = ['keyword']

# Admin configuration for ChatLog model
class ChatLogAdmin(admin.ModelAdmin):
    list_display = ('session_id', 'user_name', 'user_query', 'bot_response', 'timestamp')
    search_fields = ['session_id', 'user_name', 'user_query']
    list_filter = ['timestamp']
    ordering = ['timestamp']

# Admin configuration for Applications model
class ApplicationsAdmin(admin.ModelAdmin):
    list_display = ('application_number', 'full_name', 'status', 'admission_for', 'academic_year')
    search_fields = ['application_number', 'full_name', 'status', 'admission_for', 'academic_year']
    list_filter = ['status', 'admission_for', 'academic_year']
    ordering = ['academic_year', 'status']

# Admin configuration for Applicant model
class ApplicantAdmin(admin.ModelAdmin):
    list_display = ('full_name', 'email', 'phone_number', 'date_of_birth', 'gender')
    search_fields = ['full_name', 'email', 'phone_number']
    list_filter = ['gender']
    ordering = ['full_name']

# Admin configuration for CollegeManagement model
class CollegeManagementAdmin(admin.ModelAdmin):
    list_display = ('name', 'phone_number', 'email')
    search_fields = ['name', 'phone_number', 'email']

# Registering the models with their admin configurations
admin.site.register(Course, CourseAdmin)
admin.site.register(Admission, AdmissionAdmin)
admin.site.register(Contact, ContactAdmin)
admin.site.register(Fees, FeesAdmin)
admin.site.register(ChatbotResponse, ChatbotResponseAdmin)
admin.site.register(ChatLog, ChatLogAdmin)
admin.site.register(Applications, ApplicationsAdmin)
admin.site.register(Applicant, ApplicantAdmin)
admin.site.register(CollegeManagement, CollegeManagementAdmin)
