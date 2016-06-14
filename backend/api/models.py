from django.contrib.auth.models import User
from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator

class Location(models.Model):
    name        = models.CharField(max_length=255)

    class Meta:
        db_table = u'location'
    def __unicode__(self):
        return self.name

class Company(models.Model):
    name        = models.CharField(max_length=255)

    class Meta:
        db_table = u'company'
    def __unicode__(self):
        return self.name

class Agent(models.Model):
    name        = models.ForeignKey(User, null=True)
    #jd          = models.ForeignKey(JD,related_name='agent_jds', null=True,blank=True) #NEXT_DB

    class Meta:
        db_table = u'agent'
    def __unicode__(self):
        user_obj = User.objects.filter(id=self.name_id).values_list('username', flat=True)
        return user_obj[0] or u''


class SPOC(models.Model):
    location    = models.ForeignKey(Location)
    company     = models.ForeignKey(Company)
    #jd          = models.ForeignKey(JD,related_name='spoc_jds', null=True,blank=True) #NEXT_DB
    #Jd          =  models.CharField(max_length=255, null=True)
    name        = models.ForeignKey(User)

    class Meta:
        db_table = u'SPOC_table'
    def __unicode__(self):
        user_obj = User.objects.filter(id=self.name_id).values_list('username',flat=True)
        return user_obj[0]  or u'' #for NEXTWEALTHAPI DB
        #return self.Jd #for NEXTWEALTH_API DB

class JD(models.Model):
    job_title = models.CharField(max_length=255)
    job_description = models.TextField(max_length=255, null=True)
    company   = models.ForeignKey(Company, null=True)
    candidates_req = models.IntegerField(max_length=255, default=1)
    min_experience = models.FloatField(validators = [MinValueValidator(0.0), MaxValueValidator(58)], null=True)
    max_experience = models.FloatField(validators = [MinValueValidator(0.0), MaxValueValidator(58)], null=True)
    min_salary     = models.FloatField(validators = [MinValueValidator(0.0), MaxValueValidator(58)], null=True)
    max_salary     = models.FloatField(validators = [MinValueValidator(0.0), MaxValueValidator(58)], null=True)
    #status    = models.CharField(max_length=20,choices=STATUS, default='Open')
    start_date= models.DateField()
    end_date  = models.DateField()
    location  = models.ForeignKey(Location)
    SPOC      = models.ManyToManyField(SPOC) #for NEXTWEALTHAPI DB, null=True,blank=True
    agent     = models.ManyToManyField(Agent) #for NEXTWEALTHAPI DB ,  null=True
    #agent     = models.ForeignKey(User, null=Triue)
    STATUS    = (
        ('Closed', 'Closed'),
        ('Open', 'Open')
    )
    status    = models.CharField(max_length=20,choices=STATUS, default='Open')

    class Meta:
        db_table = u'jd_table'
    def __unicode__(self):
        return self.job_title  or u''

class StatusType(models.Model):
    status_field = models.CharField(max_length=255)

    class Meta:
        db_table = u'statu_type'
    def __unicode__(self):
        return self.status_field

class Candidate(models.Model):
    jd          = models.ForeignKey(JD, null=True)
    fname       = models.CharField(max_length=255, null=True)
    lname       = models.CharField(max_length=255, null=True)
    mobile_number = models.CharField(max_length=255, null=True, unique=True)
    email_id    = models.EmailField(max_length=255, null=True)
    location    = models.CharField(max_length=255, null=True)
    agent       = models.ForeignKey('Agent',related_name='to_agent' ,null=True, blank=True)
    #spoc        = models.ForeignKey('SPOC' ,related_name='to_spoc',null=True, blank=True)
    walk_in_date= models.DateTimeField()
    status      = models.ForeignKey(StatusType, null=True)
    remarks     =  models.TextField(max_length=512, null=True)
    created_at  = models.DateTimeField(auto_now_add=True, null=True)
    modified_at = models.DateTimeField(auto_now=True, null=True)
    class Meta:
        db_table = u'candidate'
    def __unicode__(self):
        return self.fname

class Status(models.Model):
    candidate    = models.ForeignKey(Candidate, null=True, related_name="statusModel")
    status       = models.ForeignKey(StatusType, null=True)
    created_at   = models.DateTimeField(auto_now_add=True)
    modified_at  = models.DateTimeField(auto_now=True)
    agent        = models.ForeignKey(Agent)
    remarks      = models.CharField(max_length=255)

    class Meta:
        db_table = u'status'
    def __unicode__(self):
        #status_string = StatusType
        return "status"
