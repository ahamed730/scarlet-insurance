from homepage.api.views import AppointmentAV, appointments
from django.urls import path, include
from django.http import JsonResponse
from rest_framework.routers import DefaultRouter


# router = DefaultRouter()
# router.register('appointment', AppointmentAV, basename='doctorappointment')


urlpatterns = [
# path('', include(router.urls)),
path('appointments/', appointments, name = "appointments")
]
