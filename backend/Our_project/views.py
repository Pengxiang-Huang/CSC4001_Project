from django.shortcuts import render
from Our_project.models import students


def index(request):  # request means the request sent by front-end
    return render(request, 'index1.html')

def login(request):
    id = request.POST['stuid']
    passcode = request.POST['passcode']

    students.objects.create(user_id = id, passcode = passcode)

    id = int(id)
    passcode = int(passcode)

    return render(request, 'main_page.html', context={'stuid':id})

