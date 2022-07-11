from importlib.util import spec_from_file_location
from time import time
from homepage. models import Appointment, Doctor, Patient, DoctorInformation
from .serializers import AppointmentSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view  
from rest_framework import status
from rest_framework.views import APIView
from rest_framework import generics, mixins, viewsets
from rest_framework.exceptions import ValidationError
from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from dateutil import parser
# from watchlist.api.permissions import AdminOrReadOnly, ReviewUser


class AppointmentAV(viewsets.ModelViewSet):
    serializer_class = AppointmentSerializer

    def get_queryset(self):
        if self.request.user.is_authenticated:
            patient = Patient.objects.get(email=self.request.user.email)
        else:
            patient = Patient.objects.get(email=self.request.GET.get('email'))
        return Appointment.objects.filter(patient = patient)

    def create(self, request, *args, **kwargs):
        try:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
        except:
            if  request.user.is_authenticated:
                patient = Patient.objects.get(email=request.user.email)
            else:
                patient = Patient.objects.get(email=request.data.get('email'))
            doctor = Doctor.objects.get(first_name = request.data.get('first_name'), last_name = request.data.get('last_name'))
            provider = DoctorInformation.objects.get(doctor = doctor, specialty = request.data.get('specialty'), location = request.data.get('location'))
            appointment_date = parser.parse(request.data.get('time'))
            Appointment.objects.create(time = appointment_date, reason_for_appointment = request.data.get('reason_for_appointment'), provider = provider, patient = patient)
            appointment = Appointment.objects.get(time= appointment_date, provider = provider, patient = patient)
            serializer = AppointmentSerializer(appointment)
            return Response(serializer.data, status.HTTP_201_CREATED)

