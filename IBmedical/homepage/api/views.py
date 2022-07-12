from homepage. models import Appointment, Doctor, Patient, DoctorInformation
from .serializers import AppointmentSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view , action 
from rest_framework import status
from rest_framework.views import APIView
from rest_framework import generics, mixins, viewsets
from rest_framework.exceptions import ValidationError
from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from dateutil import parser




class AppointmentAV(viewsets.ModelViewSet):
    queryset = Appointment.objects.all()
    serializer_class = AppointmentSerializer

    def get_queryset(self):
        if self.request.user.is_authenticated and self.request.user.type_of_account == 'PATIENT':
            patient = Patient.objects.get(id = self.request.user.id)
            return Appointment.objects.all().filter(patient=patient).order_by('time')
        elif self.request.user.is_authenticated and self.request.user.type_of_account == 'DOCTOR':
            doctor = Doctor.objects.get(id = self.request.user.id)
            return Appointment.objects.all().filter(provider__doctor=doctor).order_by('time')
    
    def list(self, request):
        return super().list(self, request)








        
