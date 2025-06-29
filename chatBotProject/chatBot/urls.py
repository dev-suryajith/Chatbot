from django.urls import path
from . import views
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.index, name='index'),
    path('chatbot/', views.chatbot, name='chatbot'),
    path('signup/', views.signup, name='signup'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('application/', views.application, name='application'),
    path('application_status/', views.application_status, name='application_status'),
    path('application_home/', views.application_home, name='application_home'),
    path('managementLogin/', views.managementLogin, name='managementLogin'),
    path('managementSignUp/', views.managementSignUp, name='managementSignUp'),
    path('managementDashboard/', views.managementDashboard, name='managementDashboard'),
    path('managementLogout/', views.managementLogout, name='managementLogout'),
    path('update-status/', views.update_status, name='update_status'),
    path('application_details/<int:application_id>/', views.application_details, name='application_details'),
    path('update_course/', views.update_course, name='update_course'),
    path('api/search-applications/', views.search_applications, name='search_applications'),
    path('editApplication/<int:id>', views.editApplication, name='editApplication'),
    path('analytical_charts/', views.analytical_charts, name='analytical_charts'),
    path('chatLog/', views.chatLog, name='chatLog'),
    path('dropOffList/', views.dropOffList, name='dropOffList'),
    path('viewApplicants/', views.viewApplicants, name='viewApplicants'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)