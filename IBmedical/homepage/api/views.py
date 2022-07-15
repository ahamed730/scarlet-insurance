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


@api_view(['POST'])
def appointments(request):
    if request.method == "POST":
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')

        if request.POST.get('account_type') == 'Patient' and request.POST.get('intent') == "all-appointments":
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointments =  Appointment.objects.all().filter(patient=patient).order_by('time')
            serializer = AppointmentSerializer(appointments, many=True)
            try:
                data = serializer.data
            except:
                data = {
                        'appointments' : 'none'
                }
            return Response(serializer.data)

        if request.POST.get('account_type') == 'Patient' and request.POST.get('intent') == "appointment-details":
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointments =  Appointment.objects.all().filter(patient=patient).order_by('time')
            serializer = AppointmentSerializer(appointments, many=True)
            try:
                data = serializer.data[0]
            except:
                data = {
                    'appointments' : 'none'
                }
            return Response(data)

        if request.POST.get('account_type') == 'Patient' and request.POST.get('intent') == "appointment-delete":
            time = parser.parse(request.POST.get('time'))
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointment =  Appointment.objects.get(patient=patient, time = time)
            appointment.delete()
            return Response(status.HTTP_204_NO_CONTENT)

        if request.POST.get('account_type') == 'Patient' and request.POST.get('intent') == "appointment-update":
            time = parser.parse(request.POST.get('time'))
            new_time = parser.parse(request.POST.get('new_time'))
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointment =  Appointment.objects.get(patient=patient, time = time)
            appointment.time = new_time
            appointment.save()
            return Response(status.HTTP_202_ACCEPTED)

        if request.POST.get('account_type') == 'Patient' and request.POST.get('intent') == "appointment-create":
            time = parser.parse(request.POST.get('time'))
            location = request.POST.get('location')
            specialty = request.POST.get('department')
            doctor = request.POST.get('doctor')
            doctor_first_name, doctor_last_name = doctor.split()[0], doctor.split()[1]
            doctor = Doctor.objects.get(first_name=doctor_first_name, last_name=doctor_last_name)
            reason = request.POST.get('reason_for_appointment')
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            provider = DoctorInformation.objects.get(specialty=specialty, doctor=doctor, location=location)
            Appointment.objects.create(provider=provider, patient=patient, time=time, reason_for_appointment=reason)
            return Response(status.HTTP_201_CREATED)

        if request.POST.get('account_type') == 'Patient' and request.POST.get('intent') == "locations":
            specialty = request.POST.get('department')
            doctor_info = DoctorInformation.objects.filter(specialty=specialty)
            locations = set([doc_info.location for doc_info in doctor_info])
            return Response({'locations': locations})

        if request.POST.get('account_type') == 'Patient' and request.POST.get('intent') == "doctors":
            location = request.POST.get('location')
            specialty = request.POST.get('department')
            doctor_information = DoctorInformation.objects.all().filter(location = location, specialty = specialty)
            doctors = [docinfo.doctor for docinfo in doctor_information]
            doctor_names = set([("Dr." + " " + doctor.first_name + ' ' + doctor.last_name) for doctor in doctors])
            return Response({'doctors': doctor_names})






        
