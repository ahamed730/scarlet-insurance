class DoctorRegistrationView(CreateView):
    form_class = DoctorRegistrationForm
    template_name = 'homepage/doctor_register.html'
    success_url = reverse_lazy('home')

    def form_valid(self, form):
        form.instance.username = form.instance.email.split("@")[0]
        form.instance.password = make_password(form.instance.password)
        doctor = form.save()
        doctor.is_active = True
        doctor.save()
        DoctorInformation.objects.create(doctor=doctor, location = form.cleaned_data['location'], specialty=form.cleaned_data['specialty'])
        # return super().form_valid(form)
        return HttpResponseRedirect(self.success_url)

class AppointmentView(LoginRequiredMixin, CreateView):
    login_url = reverse_lazy('login')
    form_class = AppointmentForm
    # success_url = reverse_lazy('patient-register')
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
        return HttpResponseRedirect("/")