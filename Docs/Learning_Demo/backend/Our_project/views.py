from django.shortcuts import render
from Our_project.models import students
from sphere_engine import CompilersClientV4
from sphere_engine.exceptions import SphereEngineException
import requests
import urllib.request
import json
import time

def index(request):  # request means the request sent by front-end

    return render(request, 'index1.html')

def login(request):
    id = request.POST['stuid']
    passcode = request.POST['passcode']

    students.objects.create(user_id = id, passcode = passcode)

    id = int(id)
    passcode = int(passcode)

    return render(request, 'main_page.html', context={'stuid':id})

def compile_page(request):
    return render(request, 'compile.html')

def compile(request):
    source = request.POST['source_code']
    # online compiling and running:
    accessToken = '36d4266a34888e936d9b1f20c9e634b8'
    endpoint = '6747df29.compilers.sphere-engine.com'

    # initialization
    client = CompilersClientV4(accessToken, endpoint)

    compiler = 116 # default python
    input = '111'

    response = client.submissions.create(source, compiler, input)
    task_id = response.get("id")

    response = client.submissions.get(task_id)

    executing_status = response.get("executing")
    while (executing_status):
        response = client.submissions.get(task_id)
        executing_status = response.get("executing")
    
    uri = response.get("result").get("streams").get("output").get('uri')

    contents = urllib.request.urlopen(uri).read().decode('utf-8')

    return render(request, 'compile_result.html', context={'result':contents})
