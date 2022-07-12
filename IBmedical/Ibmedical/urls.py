"""Ibmedical URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.contrib.auth import views as auth_views
from homepage.views import HomeAV, DoctorRegistrationView, PatientRegistrationView, AppointmentView, load_specialties, load_doctors

urlpatterns = [
    
    path('admin/', admin.site.urls),
    path("", HomeAV.as_view(), name='home-view'),
    path("doctor-register/", DoctorRegistrationView.as_view(), name='doctor-register'),
    path("patient-register/", PatientRegistrationView.as_view(), name='patient-register'),
    path('login/', auth_views.LoginView.as_view(
        template_name='homepage/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name ='logout'),
    path('create-appointment/', AppointmentView.as_view(), name = 'create-appointment'),
    path('ajax/load-specialties/', load_specialties, name='ajax_load_specialties'),
    path('ajax/load-doctors/', load_doctors, name='ajax_load_doctors'),
    path("api/", include('homepage.api.urls')),
    


]
