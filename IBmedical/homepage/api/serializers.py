from rest_framework import serializers
from homepage.models import Appointment

class AppointmentSerializer(serializers.ModelSerializer):

    patient = serializers.StringRelatedField(read_only=True)
    provider = serializers.StringRelatedField()
    class Meta:
        model = Appointment
        fields = '__all__' 
        