
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import HttpResponse
from django.core.mail import send_mail
import json

from .models import User
from .models import Blog_Questions
from .models import picture
from .models import Blog_Answers
import hashlib

# Create your views here.
def index(request):  # request means the request sent by front-end
    if request.method == 'GET':  #GET 返回页面
        return render(request, 'index.html')

def register(request):
    #POST 处理数据
        #1.当前用户名是否可用
        #1.插入数据[暂时明文处理]
    data = {
        'isRegister': 1
    }# control flag

    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        password = request.POST['password']
        print(username,email,password)

        #check user name. Multi-thread considerration.
        old_users = User.objects.filter(username=username)
        print(old_users)
        if (old_users):# if exists
            data['isRegister'] = 0
            return HttpResponse(json.dumps(data), content_type='application/json')
        
        ##hash the code
        m = hashlib.md5()
        m.update(password.encode())
        password_m = m.hexdigest()
        
        try: #Multi-thread considerration:唯一索引，并发写入问题。
        #insert data
            user = User.objects.create(username=username, password=password_m, email=email)
        except Exception as e:
            print('--create user error%s'%(e))
            data['isRegister'] = 0
            return HttpResponse(json.dumps(data), content_type='application/json')

        #免登录一天 session
        request.session['username'] = username
        request.session['uid'] = user.id
        #TODO 修改session储存时间为一天


        #return successful information
        return HttpResponse(json.dumps(data), content_type='application/json')

def login(request):
    if request.method == 'GET':
        ##1.检查会话状态session
        if request.session.get('username') and request.session.get('uid'):
            return HttpResponse('Success Login!')
        ##2.检查会话状态cookies
        c_username = request.COOKIES.get('username')
        c_uid = request.COOKIES.get('uid')
        if c_username and c_uid:
            #回写cookies
            request.session['username'] = username
            request.session['uid'] = user.id
            return HttpResponse('Success Login!')
        ##3. 未登陆过，则登录
        return render(request, 'login.html')
    
    elif request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        try:  #get the user infor.
            user = User.objects.get(username=username)
        except Exception as e:
            print('---login user error %s'%(e))
            return HttpResponse('Username or Password Error. Please check!')

        #compare the passsword
        m = hashlib.md5()
        m.update(password.encode())
        if m.hexdigest() != user.password:
            return HttpResponse("Username or Password Error. Please check!")

        #remember seesion,记录会话状态
        request.session['username'] = username
        request.session['uid'] = user.id
        resp = HttpResponse('Success Login!')
        #remember or not -> coockie
        if 'remember' in request.POST:
            resp.set_cookie('username', username, 3600*24*3)
            resp.set_cookie('uid', user.id, 3600*24*3)



        return resp

def main_page(request):
    
    if request.method == 'POST':
        # getting the blogs order by 'hot'
        hot_blogs = Blog_Questions.objects.order_by('-hot').values()
        data = {}
        for i in range(0,5):
            question_id = hot_blogs[i]['id']

            # getting the url of picture of the corresponding blog
            url = picture.objects.filter(question = question_id).values()[0]['url']

            # getting the amount of answers regarding to this questions
            amount_of_answers = Blog_Answers.objects.filter(question_id = question_id).count()

            # put the url into data, preparing to be sent to frontend
            temp = hot_blogs[i]
            temp['url'] = url
            temp['amount_of_answers'] = amount_of_answers
            data['blog'+str(i+1)] = temp
        
        return HttpResponse(json.dumps(data), content_type='application/json')