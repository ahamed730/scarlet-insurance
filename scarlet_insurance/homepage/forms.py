from django import forms
from .models import Doctor, Patient, Appointment

class DoctorRegistrationForm(forms.ModelForm):

    specialty = forms.CharField(max_length=255, required=True)
    location = forms.CharField(max_length=255, required=True)

    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder':'Enter Password',
        'class':'default-form-box mb-20'
    }))

    confirm_password = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder':'Confirm Password',
        'class':'default-form-box mb-20'
    }))
    class Meta:
        model = Doctor
        fields = ["first_name", 'last_name', 'phone_number', 'email', 'password', 'is_active', 'specialty', 'location']
    
    def __init__(self, *args, **kwargs):
        super(DoctorRegistrationForm, self).__init__(*args, **kwargs)
        # for field in self.fields:
        #     self.fields[field].widget.attrs['class'] = 'default-form-box mb-20'
    
    def clean(self):
        cleaned_data = super(DoctorRegistrationForm, self).clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")

        if password != confirm_password:
            raise forms.ValidationError(
                "passwords don't match"
            )
        return cleaned_data

class PatientRegistrationForm(forms.ModelForm):

    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder':'Enter Password',
        'class':'default-form-box mb-20'
    }))

    confirm_password = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder':'Confirm Password',
        'class':'default-form-box mb-20'
    }))
    class Meta:
        model = Patient
        fields = ["first_name", 'last_name', 'phone_number', 'email', 'password', 'confirm_password','is_active']
    
    def __init__(self, *args, **kwargs):
        super(PatientRegistrationForm, self).__init__(*args, **kwargs)
        # for field in self.fields:
        #     self.fields[field].widget.attrs['class'] = 'default-form-box mb-20'
    
    def clean(self):
        cleaned_data = super(PatientRegistrationForm, self).clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")

        if password != confirm_password:
            raise forms.ValidationError(
               " Please make sure your passwords match"
            )
        


class AppointmentForm(forms.ModelForm):
    class Meta:
        model = Appointment
        fields = ['reason_for_appointment']



