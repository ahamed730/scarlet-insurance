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
import humanize
from datetime import datetime




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
        first_name = request.data.get('first_name')
        last_name = request.data.get('last_name')
        print(request.data)

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "all-appointments":
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

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "all-appointments-options":
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointments =  Appointment.objects.all().filter(patient=patient).order_by('time')
            appointments = AppointmentSerializer(appointments, many=True)
            appointments = appointments.data[:]
            for appointment in appointments:
                print(appointment)
            appointment_options = [{
          "label": appointment.get('provider') + " " + parser.parse(appointment.get('time')).strftime("%B %d, %Y @ %I:%M %p"),
          "value": {
            "input": {
              "text": appointment.get('provider') + " " + parser.parse(appointment.get('time')).strftime("%B %d, %Y @ %I:%M %p")
            }
          }
        } for appointment in appointments]
            appointment_option_object = {
  "arr": [
    {
      "title": "Which appointment would you like to cancel?",
      "options": appointment_options,
      "description": "",
      "response_type": "option"
    }
  ]
}

            return Response(appointment_option_object)

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "appointment-details":
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointments =  Appointment.objects.all().filter(patient=patient).order_by('time')
            serializer = AppointmentSerializer(appointments, many=True)
            try:
                data = serializer.data[0]
                data['time'] = parser.parse(data['time']).strftime("%B %d, %Y @ %I:%M %p")
            except:
                data = {
                    'appointments' : 'none'
                }
            return Response(data)

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "appointment-delete":
            time = parser.parse(request.data.get('time'))
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointment =  Appointment.objects.get(patient=patient, time = time)
            appointment.delete()
            return Response({"status":"success"})

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "appointment-update":
            time = parser.parse(request.data.get('time').replace('@', ' '))
            new_time = parser.parse(request.data.get('new_time'))
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            appointment =  Appointment.objects.get(patient=patient, time = time)
            appointment.time = new_time
            appointment.save()
            return Response({'status': 'succeeded'}, status.HTTP_202_ACCEPTED)

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "appointment-create":
            time = parser.parse(request.data.get('time'))
            location = request.data.get('location')
            specialty = request.data.get('department')
            doctor = request.data.get('doctor')
            doctor_first_name, doctor_last_name = doctor.split()[1], doctor.split()[2]
            doctor = Doctor.objects.get(first_name=doctor_first_name, last_name=doctor_last_name)
            reason = request.data.get('reason_for_appointment')
            patient = Patient.objects.get(first_name = first_name, last_name = last_name)
            provider = DoctorInformation.objects.get(specialty=specialty, doctor=doctor, location=location)
            Appointment.objects.create(provider=provider, patient=patient, time=time, reason_for_appointment=reason)
            appointment = Appointment.objects.get(provider=provider, patient=patient, time=time)
            serializer = AppointmentSerializer(appointment)
            return Response(serializer.data, status.HTTP_201_CREATED)

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "locations":
            specialty = request.data.get('department')
            doctor_info = DoctorInformation.objects.filter(specialty=specialty)
            locations = set([doc_info.location for doc_info in doctor_info])
            return Response({'locations': locations})
        
        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "locations-options":
            specialty = request.data.get('department')
            doctor_info = DoctorInformation.objects.filter(specialty=specialty)
            locations = set([doc_info.location for doc_info in doctor_info])
            locations_options = [{
          "label": location,
          "value": {
            "input": {
              "text": location
            }
          }
        } for location in locations]
            location_option_object = {
  "arr": [
    {
      "title": "Where would you like to book your appointment",
      "options": locations_options,
      "description": "",
      "response_type": "option"
    }
  ]
}
            return Response(location_option_object)

        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "doctors":
            location = request.data.get('location')
            specialty = request.data.get('department')
            doctor_information = DoctorInformation.objects.all().filter(location = location, specialty = specialty)
            doctors = [docinfo.doctor for docinfo in doctor_information]
            doctor_names = set([("Dr." + " " + doctor.first_name + ' ' + doctor.last_name) for doctor in doctors])
            return Response({'doctors': doctor_names})
        
        if request.data.get('account_type') == 'Patient' and request.data.get('intent') == "doctors-options":
            location = request.data.get('location')
            specialty = request.data.get('department')
            doctor_information = DoctorInformation.objects.all().filter(location = location, specialty = specialty)
            doctors = [docinfo.doctor for docinfo in doctor_information]
            doctor_names = set([("Dr." + " " + doctor.first_name + ' ' + doctor.last_name) for doctor in doctors])
            doctors_options = [{
          "label": doctor,
          "value": {
            "input": {
              "text": doctor
            }
          }
        } for doctor in doctor_names]
            print(doctors_options)
            doctor_option_object = {
  "arr": [
    {
      "title": "Please select an available doctor below?",
      "options": doctors_options,
      "description": "",
      "response_type": "option"
    }
  ]
}
            print(doctor_option_object)
            return Response(doctor_option_object)

        if request.data.get('account_type') == 'Doctor' and request.data.get('intent') == "appointment-details":
            doctor = Doctor.objects.get(first_name = first_name, last_name = last_name)
            appointments = Appointment.objects.all().filter(provider__doctor=doctor).order_by('time')
            serializer = AppointmentSerializer(appointments, many=True)
            try:
                data = serializer.data[0]
                data['time'] = parser.parse(data['time']).strftime("%B %d, %Y @ %I:%M %p")
            except:
                data = {
                    'appointments' : 'none'
                }
            return Response(data)
        
        if request.data.get('account_type') == 'Doctor' and request.data.get('intent') == "appointment-update":
            print(request.data)
            time = parser.parse(request.data.get('time'))
            new_time = parser.parse(request.data.get('new_time'))
            doctor = Doctor.objects.get(first_name = first_name, last_name = last_name)
            appointment =  Appointment.objects.all().filter(provider__doctor=doctor, time = time)[0]
            appointment.time = new_time
            appointment.save()
            return Response(status.HTTP_202_ACCEPTED)
        






        
