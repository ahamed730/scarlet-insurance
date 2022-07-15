from dateutil import parser
from django.shortcuts import redirect, render
from rest_framework.response import Response
from rest_framework.views import APIView
from django.views.generic.edit import CreateView, FormView
from .models import Doctor, DoctorInformation, Patient, Appointment
from .forms import DoctorRegistrationForm, PatientRegistrationForm, AppointmentForm
from django.contrib.auth.hashers import make_password
from django.urls import reverse_lazy, reverse
from django.http import HttpResponseRedirect
from datetime import datetime as dt
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.base import TemplateView
from django.core.exceptions import ValidationError



# Create your views here.
class HomeAV(LoginRequiredMixin, TemplateView):
    login_url = reverse_lazy('login')
    template_name = 'homepage/home.html'

class DoctorRegistrationView(CreateView):
    form_class = DoctorRegistrationForm
    template_name = 'homepage/doctor_register.html'
    success_url = reverse_lazy('home-view')

    def form_valid(self, form):
        form.instance.username = form.instance.email.split("@")[0]
        form.instance.password = make_password(form.instance.password)
        doctor = form.save()
        doctor.is_active = True
        doctor.save()
        DoctorInformation.objects.create(doctor=doctor, location = form.cleaned_data['location'], specialty=form.cleaned_data['specialty'])
        # return super().form_valid(form)
        return HttpResponseRedirect(self.success_url)

class PatientRegistrationView(CreateView):
    form_class = PatientRegistrationForm
    template_name = 'homepage/patient_register.html'
    success_url = reverse_lazy('login')

    def form_valid(self, form):
        form.instance.username = form.instance.email.split("@")[0]
        form.instance.password = make_password(form.instance.password)
        patient = form.save()
        patient.is_active = True
        patient.save()
        return super().form_valid(form)
    


class AppointmentView(LoginRequiredMixin, FormView):
    login_url = reverse_lazy('login')
    form_class = AppointmentForm
    success_url = reverse_lazy('home-view')
    template_name = 'homepage/make-appointment.html'

    def form_valid(self, form):
        date = self.request.POST.get('date')
        time = self.request.POST.get('time')
        datetime = parser.parse(date + ' ' + time)
        location = self.request.POST.get('location')
        specialty = self.request.POST.get('department')
        doctor = self.request.POST.get('doctor')
        first_name, last_name = doctor.split()[1], doctor.split()[2]
        doctor = Doctor.objects.get(first_name=first_name, last_name=last_name)
        reason = self.request.POST.get('reason_for_appointment')
        patient = Patient.objects.get(email=self.request.user.email)
        provider = DoctorInformation.objects.get(specialty=specialty,doctor=doctor, location=location)
        Appointment.objects.create(provider=provider, patient=patient, time=datetime, reason_for_appointment=reason)
        return HttpResponseRedirect(self.success_url)
        
    

        
        
    

def load_specialties(request):
    location = request.GET.get('location')
    doctor_info = DoctorInformation.objects.filter(location=location)
    specialties = set([doc_info.specialty for doc_info in doctor_info])
    return render(request, "homepage/specialties.html", {'specialties': specialties})

def load_doctors(request):
    location = request.GET.get('location')
    specialty = request.GET.get('specialty')
    doctor_information = DoctorInformation.objects.all().filter(location = location, specialty = specialty)
    doctors = [docinfo.doctor for docinfo in doctor_information]
    doctor_names = set([("Dr." + " " + doctor.first_name + ' ' + doctor.last_name) for doctor in doctors])
    return render(request, "homepage/doctors.html", {'doctors': doctor_names})
        