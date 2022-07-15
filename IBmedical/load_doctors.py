from venv import create
from faker import Faker
import django
import os
from django.contrib.auth.hashers import make_password
import random 



os.environ.setdefault("DJANGO_SETTINGS_MODULE", "Ibmedical.settings")
django.setup()


from homepage.models import Doctor, DoctorInformation, Patient, Appointment



def create_docs():
    fake = Faker()
    locations = ['New York, NY', 'Jersey City, NJ', 'Brooklyn, NY']
    specialties = ['Cardiology', 'Neurology', 'Pathology', 'Ophthalmology', 'Internal Medicine', 'Dermatology']

    for i in range(50):
        first_name, last_name = fake.name().split()[0], fake.name().split()[1]
        phone_number = fake.phone_number()
        location = random.choice(locations)
        specialty = random.choice(specialties)
        email = f"{first_name}.{last_name}@Ibmedical.com"
        username = first_name[0]+last_name
        password = make_password('ibm1234')
        Doctor.objects.create(username=username, password=password, first_name=first_name, last_name=last_name, email=email, phone_number=phone_number)
        doctor = Doctor.objects.get(email=email)
        DoctorInformation.objects.create(doctor=doctor, location=location, specialty=specialty)

def create_patient():
    fake = Faker()
    

    for i in range(50):
        first_name, last_name = fake.name().split()[0], fake.name().split()[1]
        phone_number = fake.phone_number()
        email = f"{first_name}.{last_name}@gmail.com"
        username = first_name[0]+last_name
        password = make_password('ibm1234')
        Patient.objects.create(first_name=first_name, last_name=last_name, phone_number=phone_number, email=email, password=password,username=username)


# create_patient()
# create_docs()
# appointment = Appointment.objects.get(pk=29)
# appointment.reason_for_appointment = "my chest hurts"
# appointment.save()
doctor = Doctor.objects.get(first_name="Cheryl", last_name="Lynch")
provider = DoctorInformation.objects.get(specialty="Cardiology", doctor=doctor, location="Jersey City, NJ")
print(provider)

    

