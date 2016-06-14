from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.models import Group
from django.contrib.auth.admin import UserAdmin
from .models import *

admin.site.register(Location)
admin.site.register(Company)
#admin.site.register(JD)
admin.site.register(Agent)
#admin.site.register(Candidate)
admin.site.register(SPOC)
admin.site.register(Status)
admin.site.register(StatusType)

#class CandidateAdmin(admin.ModelAdmin):
#    list_display = ["fname","jd","walk_in_date","mobile_number","status"]
#admin.site.register(Candidate, CandidateAdmin)

class JDAdmin(admin.ModelAdmin):
    list_display = ["job_title","id","candidates_req","start_date","end_date"]
admin.site.register(JD, JDAdmin)

class UserAdmin(UserAdmin):
    list_display = ["username","id"]
admin.site.unregister(User)
admin.site.register(User, UserAdmin)
# Register your models here.
