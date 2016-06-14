from django.db.models.signals import post_save
from django.db.models.signals import pre_save
from django.dispatch import receiver
from django.contrib.auth.models import User
from django.contrib.auth.models import Group
from models import *

@receiver(post_save, sender=Agent)
def set_agent(sender, instance, **kwargs):
    print "here"
    user_obj = User.objects.filter(username=instance.name).values_list('id', flat=True)
    group_obj = Group.objects.get(name='Agent')
    group_obj.user_set.add(user_obj[0])
    print "successs"

@receiver(post_save, sender=SPOC)
def set_spoc(sender, instance, **kwargs):
    print "here"
    user_obj = User.objects.filter(username=instance.name).values_list('id', flat=True)
    group_obj = Group.objects.get(name='SPOC')
    group_obj.user_set.add(user_obj[0])
    print "successs"

@receiver(post_save, sender=Candidate)
def log_status(sender, instance, **kwargs):
    '''status_obj = Status.objects.filter(candidate_id = instance.id)
    if status_obj:

        print "Already"
        status_obj[0].status_id = instance.status_id
        status_obj[0].agent_id  = instance.agent_id
        status_obj[0].remarks   = instance.remarks
        status_obj[0].save()
    else:

        print "NEW" '''
    status_obj = Status(candidate_id = instance.id, status_id = instance.status_id, agent_id  = instance.agent_id,
                remarks   = instance.remarks)
    status_obj.save()
    print "logged"
