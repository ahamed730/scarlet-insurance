from django.contrib import admin
from .models import Account, Appointment, DoctorInformation
from django.contrib.auth.admin import UserAdmin
from nested_admin.nested import NestedStackedInline

class AccountAdmin(UserAdmin):
    list_display = ('email', "type_of_account", 'first_name', 'last_name', 'username', 'last_login', 'is_active','date_joined' )
    filter_horizontal = ()
    list_filter = (["type_of_account"])
    fieldsets = ()
    readonly_fields = ('last_login', 'date_joined')
    ordering = ('-last_login',)

class DoctorInformationAdmin(admin.ModelAdmin):
    list_display = ('doctor', 'specialty', 'location')
    list_filter = ( 'specialty', 'location')

class AppointmentAdmin(admin.ModelAdmin):
    list_display = ('provider', "patient", 'time', 'reason_for_appointment')
    list_filter = ("patient", 'time')



admin.site.register(Account, AccountAdmin)
admin.site.register(DoctorInformation, DoctorInformationAdmin)
admin.site.register(Appointment, AppointmentAdmin)