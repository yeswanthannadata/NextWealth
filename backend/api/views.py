import json
import MySQLdb
import datetime
from dateutil import parser as date_parser
from django.http import HttpResponse as OrigHttpResponse

from django.shortcuts import render
from django.template import RequestContext
from django.views.decorators.csrf import csrf_exempt
from django.contrib import auth
from django.contrib.auth import authenticate
from django.contrib.auth.views import logout

from src import *
from file_import import *
from django.db.models import Q
from models import JD as JobDesTable
from models import Agent
from models import SPOC
from models import Candidate

from auth.decorators import loginRequired
from common.utils import getHttpResponse as HttpResponse
from common.decorators import allowedMethods

SOH_XL_HEADERS = ['FName', 'LName','Mobile','MailId','JDId','AgentId','ScheduledDate']
SOH_XL_MAN_HEADERS = ['FName', 'LName','Mobile','MailId','JDId','AgentId','ScheduledDate']
customer_data = {}

@loginRequired
@allowedMethods(["GET"])
def jds(request):

    user_group = request.user.groups.values_list('name',flat=True)
    user_id = request.user.id

    if user_group[0] == "Agent":
        #agent_name = request.user.username
        agent_obj = Agent.objects.filter(name=user_id).values_list('id', flat=True)
        jdObjs   = JobDesTable.objects.filter(agent=agent_obj[0]).values('id','job_title',
            'location','candidates_req','min_experience','max_experience','job_description','company',
            'min_salary','max_salary','start_date','end_date','status', 'agent')

    elif user_group[0] == "SPOC":
        spoc_obj = SPOC.objects.filter(name=user_id).values_list('id', flat=True)
        jdObjs   = JobDesTable.objects.filter(SPOC=spoc_obj[0]).values('id','job_title','location',
            'candidates_req','min_experience','max_experience','job_description','company','min_salary',
            'max_salary','start_date','end_date','status', 'agent')


    else:
        jdObjs = JobDesTable.objects.values('id','job_title','location','candidates_req','min_experience',
            'max_experience','job_description','company','min_salary','max_salary','start_date','end_date','status');

    resp_data = []
    for jdObj in jdObjs:
        jd = jdObj["job_title"]
        li = JobDesTable.objects.filter(job_title=jd).values_list('id')
        sch_count = Candidate.objects.filter(jd_id__in=li,status=4).count()
        pass_count = Candidate.objects.filter(jd_id__in=li,status=5).count()
        locationObj = Location.objects.filter(id=jdObj["location"]).values_list('name', flat=True)
        resp_data.append({"id": jdObj["id"], "name": jdObj["job_title"], "location": locationObj[0], 
            "candidates_req": jdObj["candidates_req"],"min_experience":jdObj["min_experience"], 
            "max_experience":jdObj["max_experience"],"job_description":jdObj["job_description"],
            "company":jdObj["company"],"min_salary":jdObj["min_salary"],"max_salary":jdObj["max_salary"],
            "start_date":jdObj["start_date"].strftime('%m/%d/%Y'),"end_date":jdObj["end_date"].strftime('%m/%d/%Y'),
            "status":jdObj["status"],"scheduled":sch_count,"interview_pass":pass_count})

    return HttpResponse(resp_data)


def status(request):
    can_status = request.POST.get('status')
    can_id = request.POST.get('can_id')
    status_id_of_request = StatusType.objects.filter(status_field=can_status)#.values_list('id')
    status_update = Candidate.objects.filter(id=can_id)[0]#.status=status_id_of_request
    status_update.status=status_id_of_request[0]
    status_update.save()

    return OrigHttpResponse("success")

def candidates(request):
    resp_data = []

    if request.user.is_authenticated():
        jd          = request.GET.get('jd').split('-')[0]
        user_group  = request.user.groups.values_list('name',flat=True)
        user_id     = request.user.id
        user_name   = request.user.username
        session_key = request.GET.get('session_key')
        jd_list     = JobDesTable.objects.filter(job_title=jd).values_list('id')

        if user_group[0] == "Agent":
            agent_id        = Agent.objects.filter(name_id=user_id).values_list('id', flat=True) #take agent id
            candidate_list  = Candidate.objects.filter(jd_id__in=jd_list, agent_id=agent_id)


        elif user_group[0] == "SPOC":
            status_needed   = ['Scheduled', 'Interview Pass', 'Interview Fail', 'No Show']
            satus_id_list   = StatusType.objects.filter(status_field__in= status_needed).values_list('id', flat= True)
            spoc_id         = SPOC.objects.filter(name_id= user_id).values_list('id', flat= True) #take SPOC id
            jd_list     = JobDesTable.objects.filter(job_title=jd, SPOC= spoc_id).values_list('id')
            candidate_list  = Candidate.objects.filter(jd_id__in= jd_list, status_id__in= satus_id_list)

        else:
            candidate_list  =  Candidate.objects.filter(jd_id__in=jd_list)



        for candidate in candidate_list:
            resp_data.append({"id":candidate.id, "name": candidate.fname + " " + candidate.lname,
            "walk_in_date": candidate.walk_in_date.strftime('%m/%d/%Y'), "status": candidate.status.status_field,
            "mobile_number":candidate.mobile_number, "email_id":candidate.email_id, "location":candidate.location,
            "agent_name": str(candidate.agent.name), "created_at": candidate.created_at.strftime('%m/%d/%Y'), 
            "remarks" : candidate.remarks})
        print resp_data

    return OrigHttpResponse(json.dumps(resp_data),'application/json')

def add_candidate(request):

    if request.user.is_authenticated():
        user_id = request.user.id
        fname   = request.GET.get('fname')
        lname   = request.GET.get('lname')
        date    = request.GET.get('date')
        jd_name = request.GET.get('jd').split('-')[0]
        email   = request.GET.get('email')
        mobile  = request.GET.get('mobile')
        remarks = request.GET.get('remarks')
        if remarks:
            pass
        else:
            remarks = "New"
        jd_id   = JobDesTable.objects.filter(job_title=jd_name).values('id')
        date    = date_parser.parse(date.replace(' GMT ',' GMT+'))
        date    = date_parser.parse('-'.join(str(date).split('-')[:-1]))
        agent_id        = Agent.objects.filter(name_id = user_id).values_list('id', flat= True)[0]

        new_can = Candidate(jd_id = jd_id[0]['id'], location="",fname = fname,lname = lname,walk_in_date = date,email_id = email,
                  mobile_number = mobile,status_id = 1,agent_id = agent_id, remarks = remarks)
        new_can.save()
        data = {'status':'success'}

    else:
        data = {'status':'failed'}

    return HttpResponse(data)


#@loginRequired
#@allowedMethods(["GET"])
def bulk_update(request):
    first_name = request.get('fname')
    last_name  = request.get('lname')
    mobile     = request.get('mobile')
    mobile     = int(float(mobile))
    walkin_date= request.get('walkindate')
    jd_id      = request.get('jdid')
    jd_id      = int(float(jd_id))
    mail_id    = request.get('mailid')
    agent_id   = request.get('agentid')
    agent_id   = int(float(agent_id))
    new_can = Candidate(jd_id=jd_id, fname=first_name, lname=last_name, mobile_number=mobile, walk_in_date=walkin_date, email_id=mail_id, agent_id=agent_id, status_id=1, location='', remarks='New')
    new_can.save()

def update_candidate(request):

    if request.user.is_authenticated():
        can_id  = request.GET.get('id')
        fname   = request.GET.get('fname')
        lname   = request.GET.get('lname')
        date    = request.GET.get('date')
        mobile  = request.GET.get('mobile')
        email   = request.GET.get('email')
        status  = request.GET.get('status')
        status_id_of_request = StatusType.objects.filter(status_field=status.replace('_', ' '))
        remarks = request.GET.get('remarks')
        can_sta = Candidate.objects.filter(id=can_id)[0]
        if fname:
            can_sta.fname = fname
        if lname:
            can_sta.lname = lname
        if mobile:
            can_sta.mobile_number = mobile
        if email:
            can_sta.email_id = email
        if remarks:
            can_sta.remarks = remarks
        if status:
            can_sta.status = status_id_of_request[0]
        can_sta.save()
    return HttpResponse("Hello")



def excel_upload(request):
        fname = request.FILES['myfile']
        var = fname.name.split('.')[-1].lower()
        if var not in ['xls', 'xlsx', 'xlsb']:
                return HttpResponse("Invalid File")
        else:
                try:
                        open_book = open_workbook(filename=None, file_contents=fname.read())
                        open_sheet = open_book.sheet_by_index(0)
                except:
                        return HttpResponse("Invalid File")
                sheet_headers = validate_sheet(open_sheet, request)
                for row_idx in range(1, open_sheet.nrows):
                        for column, col_idx in sheet_headers:
                                cell_data = get_cell_data(open_sheet, row_idx, col_idx)
                                if column == 'fname':
                                        customer_data['fname'] = ''.join(cell_data)
                                if column == 'lname':
                                        customer_data['lname'] = ''.join(cell_data)
                                if column == 'mobile':
                                        customer_data['mobile'] = ''.join(cell_data)
                                if column == 'mailid':
                                        customer_data['mailid'] = ''.join(cell_data)
                                if column == 'jdid':
                                        customer_data['jdid'] = ''.join(cell_data)
                                if column == 'agentid':
                                        customer_data['agentid'] = ''.join(cell_data)
                                if column == 'scheduleddate':
                                        #cell_data = format_date(cell_data)
                                        cell_data = xlrd.xldate_as_tuple(int(cell_data.split('.')[0]), 0)
                                        cell_data ='%s-%s-%s' % (cell_data[0], cell_data[1], cell_data[2])
                                        customer_data['walkindate'] = ''.join(cell_data)
                        var = bulk_update(customer_data)

        return HttpResponse("Hello")

def get_order_of_headers(open_sheet, Default_Headers, mandatory_fileds=[]):
    indexes, sheet_indexes = {}, {}
    sheet_headers = open_sheet.row_values(0)
    lower_sheet_headers = [i.lower() for i in sheet_headers]
    if not mandatory_fileds:
        mandatory_fileds = Default_Headers

    max_index = len(sheet_headers)
    is_mandatory_available = set([i.lower() for i in mandatory_fileds]) - set([j.lower() for j in sheet_headers])
    for ind, val in enumerate(Default_Headers):
        val = val.lower()
        if val in lower_sheet_headers:
            ind_sheet = lower_sheet_headers.index(val)
            sheet_indexes.update({val: ind_sheet})
        else:
            ind_sheet = max_index
            max_index += 1
        #comparing with lower case for case insensitive
        #Change the code as declare *_XL_HEADEERS and *_XL_MAN_HEADERS
        indexes.update({val: ind_sheet})
    return is_mandatory_available, sheet_indexes, indexes

def get_cell_data(open_sheet, row_idx, col_idx):
    try:
        cell_data = open_sheet.cell(row_idx, col_idx).value
        cell_data = str(cell_data)
        if isinstance(cell_data, str):
            cell_data = cell_data.strip()
    except IndexError:
        cell_data = ''
    return cell_data

def format_date(cell_data):
    if not cell_data: return ''
    cell_data = xlrd.xldate_as_tuple(int(cell_data), 0)
    cell_data ='%s-%s-%s' % (cell_data[0], cell_data[1], cell_data[2])

    return date

def validate_sheet(open_sheet, request):
    sheet_headers = []
    #brand_channels = bran_chan_func(request)
    if open_sheet.nrows > 0:
        is_mandatory_available, sheet_headers, all_headers = get_order_of_headers(open_sheet, SOH_XL_HEADERS, SOH_XL_MAN_HEADERS)
        sheet_headers = sorted(sheet_headers.items(), key=lambda x: x[1])
        all_headers = sorted(all_headers.items(), key=lambda x: x[1])
        if is_mandatory_available:
            status = ["Fields are not available: %s" % (", ".join(list(is_mandatory_available)))]
            index_status.update({1: status})
            return "Failed", status

    else:
        status = "Number of Rows: %s" % (str(open_sheet.nrows))
        index_status.update({1: status})
    return sheet_headers

