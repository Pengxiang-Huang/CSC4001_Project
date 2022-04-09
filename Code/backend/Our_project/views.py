from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import HttpResponse
from django.core import mail
from django.core.mail import send_mail
import json
from django.db import connection    # allow Django to use the original SQL statements
from datetime import date, datetime
import os
import random
import _thread
import time
import queue
from sphere_engine import CompilersClientV4
from sphere_engine.exceptions import SphereEngineException
import requests
import urllib.request

from .models import User
from .models import Blog_Questions
from .models import picture
from .models import Blog_Answers
from .models import user_like_question
from .models import user_follow_question
from .models import user_follow_group
from .models import user_like_answer
from .models import Group
from .models import sub_group
from .models import file
import hashlib
import markdown

# 重写python的datetime类型
class ComplexEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.strftime('%Y-%m-%d %H:%M:%S')
        elif isinstance(obj, date):
            return obj.strftime('%Y-%m-%d')
        else:
            return json.JSONEncoder.default(self, obj)


#校验登陆状态：装饰器。
def check_state(fn):# fn is the views
    def wrap(request, *args, **kwargs): #parameters of views
        if 'username' not in request.session or 'uid' not in request.session:
            c_username = request.COOKIES.get('username')
            c_uid = request.COOKIES.get('uid')
            if not c_username or not c_uid:
                return HttpResponseRedirect('/index')
            else:
                #write back
                request.session['username'] = c_username
                request.session['uid'] = c_uid
        return fn(request, *args, **kwargs)
    return wrap

#生成密码
def code(n = 6):
    all_code = '012345678mchjsmejrigebriruwioihgdvbhserjebssse9P'
    index = len(all_code)
    code = ''
    for  i in range(n):
        num = random.randint(0,index-1)
        code += all_code[num]
    return code

##############################
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
            return HttpResponseRedirect('/first')
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
        print(username)
        print(password)

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

def logout(request):
    #delete
    if 'username' in request.session:
        del request.session['username']
    if 'uid' in request.session:
        del request.session['uid']
    
    resp = HttpResponseRedirect('/login')
    if 'username' in request.COOKIES:
        resp.delete_cookie('username')
    if 'uid' in request.COOKIES:
        resp.delete_cookie('uid')
    return resp


@check_state
def after_login(request):
    return render(request, 'after_index.html')


def update(request):
    
    data = {    #api detail.
        'isRegister': 1
    }# control flag

    if request.method == 'POST':
        _type = request.POST['type']
        newVal = request.POST['newVal']
        oldName = request.POST['username']
        print(_type, newVal, oldName)

        if _type == 'Reset Username':
            #更新用户名
            old_users = User.objects.filter(username=newVal)
            if (old_users):# if exists
                data['isRegister'] = 0  #need to adjust
                return HttpResponse('UserName has been taken')
            else:   #valid username
                user = User.objects.get(username=oldName)
                user.username = newVal
                user.save()
                return HttpResponse('UserName Reset successfully!')
        
        elif _type == 'Reset Password':
            #更新密码
            ##hash the code
            m = hashlib.md5()
            m.update(newVal.encode())
            password_m = m.hexdigest()

            user = User.objects.get(username=oldName)
            user.password = password_m
            user.save()
            return HttpResponse('Password Reset successfully!')



#not yet
def sendEmail(request):
    #send email heres
    #is href a POST or a GET request?
    if request.method == 'POST':
        try: 
            email = request.POST['email']
        except:        # if it is a WSGIRequest, it don't have .POST[""] method, so we have to retrieve it by ourselves
            email = request.META["QUERY_STRING"]
            for i in range(0, len(email)):
                if (email[i] == "="):
                    email = email[i+1:]
                    break
        code_send = code()
        print(code_send)
        R_list = []
        R_list.append(email)
        mail.send_mail(subject='Register code', message=code_send, from_email='1092298689@qq.com', recipient_list=R_list)

        data = {}
        data["code"] = code_send
        
        return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')#需要把信息验证码一起用字典传过去、或者设置全局变量。

def setQuestion(request):
    data = {
        'isRegister': 1
    }# control flag

    if request.method == 'POST':
        title = request.POST['title']
        author_id = request.POST['author_id']
        group_type = request.POST['group_type']
        sub_group_type = request.POST['sub_group_type']
        content = request.POST['content']
        content_format = request.POST['content_format']
        like = request.POST['like']
        follow = request.POST['follow']
        hot = request.POST['hot']
        views = request.POST['views']

        try: 
        #insert data
            user = Blog_Questions.objects.create(title=title, author_id=author_id, group_type=group_type, sub_group_type=sub_group_type, \
                                                content=content, content_format=content_format, like=like, follow=follow, hot=hot, views=views)
        except Exception as e:
            print('--Insert question error%s'%(e))
            data['isRegister'] = 0
            return HttpResponse(json.dumps(data), content_type='application/json')

        #if success
        return HttpResponse(json.dumps(data), content_type='application/json')

#提出问题并放入数据库
#需要对接如何返回
def setQuestion(request):
    data = {
        'ok': 1
    }# control flag

    if request.method == 'POST':
        title = request.POST['title']
        author_id = request.POST['author_id']
        group_type = request.POST['group_type']
        sub_group_type = request.POST['sub_group_type']
        content = request.POST['content']
        content_format = request.POST['content_format']
        like = request.POST['like']
        follow = request.POST['follow']
        hot = request.POST['hot']
        views = request.POST['views']

        try: 
        #insert data
            user = Blog_Questions.objects.create(title=title, author_id=author_id, group_type=group_type, sub_group_type=sub_group_type, \
                                                content=content, content_format=content_format, like=like, follow=follow, hot=hot, views=views)
        except Exception as e:
            print('--Insert question error%s'%(e))
            data['ok'] = 0
            return HttpResponse(json.dumps(data), content_type='application/json')

        #if success
        return HttpResponse(json.dumps(data), content_type='application/json')

#基于title相似度写的问题搜索
def searchQuestion(request):
    if request.method == 'POST':
        similarity = 0
        answerList = []
        question = request.POST['question']
        questionElem = question.split(' ')
        print(questionElem)

        DBlist = []
        #get the db values
        titleDB = Blog_Questions.objects.values('titles')
        for title in titleDB:   
            DBlist.append(title['titles'])

        # start to search
        for DBitem in DBlist:
            similarity = 0
            for title in questionElem:
                if title in DBitem:
                    similarity += 1
            answerList.append(similarity)
        #answerList contains all similarity in the order of id
        print(similarity)
        
        maxSimilrty = len(questionElem)
        positionList = []
        returnNumberMax = 2 #adjust the #of return answer
        for i in range(maxSimilrty):
            searchValue = maxSimilrty - i
            if (answerList.count(searchValue) > 0):
                position = answerList.index(searchValue)
                positionList.append(position)
                if (len(positionList) == returnNumberMax):
                    break
            else:
                continue
        
        #finially, return the searched answer
        answerTitle = []
        answerContent = []
        for i in range(returnNumberMax):
            answerTitle.append(positionList[i])
        
        content = Blog_Questions.objects.values('content')
        for i in range(returnNumberMax):
            answerContent.append(content[i]['content'])
        


##########################################
# 根据hot排序，返回5个当前热门的问题
def main_page(request):
    
    if request.method == 'POST':
        username = request.POST['username']

        userid = User.objects.filter(username = username).values()[0]['id']

        # getting the blogs, order by 'hot'
        hot_blogs = Blog_Questions.objects.order_by('-hot').values()
        data = {}
        for i in range(0, min(5, len(hot_blogs))):
            question_id = hot_blogs[i]['id']

            # check whether the current user has liked this blog_question. If the current user has liked this blog, return isliked = 1
            isliked = 0
            if (user_like_question.objects.filter(question_id = question_id, id = userid)):
                isliked = 1

            # check whether the current user has followed this blog_question. If the current user has followed this blog, return isfollowed = 1
            isfollowed = 0
            if (user_follow_question.objects.filter(question_id = question_id, id = userid)):
                isfollowed = 1

            # getting the url of picture of the corresponding blog
            url = picture.objects.filter(question = question_id).values()[0]['url']

            # getting the amount of answers regarding to this questions
            amount_of_answers = Blog_Answers.objects.filter(question_id = question_id).count()

            if (hot_blogs[i]['content_format'] == "Markdown"):
                content = hot_blogs[i]["content"]
                raw_content = get_raw(get_HTML(content))
            else:
                raw_content = hot_blogs[i]["content"]

            if (len(raw_content) > 140):
                raw_content = raw_content[0:140] + "..."

            # put the url, whether user has liked/followed the blog into data, preparing to be sent to frontend
            temp = hot_blogs[i]
            temp['isliked'] = isliked
            temp['isfollowed'] = isfollowed
            temp['url'] = url
            temp['content'] = raw_content
            temp['amount_of_answers'] = amount_of_answers
            data['blog'+str(i+1)] = temp
        
        return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

# 根据用户名，返回用户关注的问题
def my_follow(request):

    if request.method == 'POST':
        # getting the username from POST request
        # username = request.POST.get('username', False)
        username = request.POST['username']

        userid = User.objects.filter(username = username).values()[0]['id']

        # get a list of question ids the current user is following
        question_ids = user_follow_question.objects.filter(id = userid).values()

        data = {}
        for i in range (0, len(question_ids)):
            question_id = question_ids[i]['question_id']

            # getting the url of picture of the corresponding blog
            url = picture.objects.filter(question = question_id).values()[0]['url']

            # getting the amount of answers regarding to this questions
            amount_of_answers = Blog_Answers.objects.filter(question_id = question_id).count()

            # get the full content of the questions
            question = Blog_Questions.objects.filter(id = question_id).values()

            # check whether the current user has liked this blog_question. If the current user has liked this blog, return isliked = 1
            isliked = 0
            if (user_like_question.objects.filter(question_id = question_id, id = userid)):
                isliked = 1

            # check whether the current user has followed this blog_question. If the current user has followed this blog, return isfollowed = 1
            isfollowed = 0
            if (user_follow_question.objects.filter(question_id = question_id, id = userid)):
                isfollowed = 1

            # put the url into data, preparing to be sent to frontend
            temp = question[0]

            if (question[0]['content_format'] == "Markdown"):
                content = question[0]["content"]
                raw_content = get_raw(get_HTML(content))
            else:
                raw_content = question[0]["content"]

            if (len(raw_content) > 140):
                raw_content = raw_content[0:140] + "..."

            temp['url'] = url
            temp['isliked'] = isliked
            temp['isfollowed'] = isfollowed
            temp['content'] = raw_content
            temp['amount_of_answers'] = amount_of_answers
            data['blog'+str(i+1)] = temp

        return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

# 根据用户名，返回该用户关注的分组
def my_group(request):

    if request.method == 'POST':
        username = request.POST['username']

        userid = User.objects.filter(username = username).values()[0]['id']

        group_names = user_follow_group.objects.filter(id = userid).values()

        data = {}
        for i in range(0, len(group_names)):
            group_name = group_names[i]['group_name']
            
            group = Group.objects.filter(group_name=group_name).values()[0]

             # getting the url of picture of the corresponding blog
            url = picture.objects.filter(group_name = group_name).values()[0]['url']

            temp = group
            temp['url'] = url

            data['group'+str(i+1)] = temp

        return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')


# /unUnswered: 按关注的数量返回高赞未回答的问题
def unUnswered(request):

    if request.method == 'POST':
        
        # get the information of current user
        username = request.POST['username']

        userid = User.objects.filter(username = username).values()[0]['id']

        cursor = connection.cursor()
        
        # get the un-unswered questions ordered by amount of follows
        cursor.execute("select * from Our_project_blog_questions where id not in (select question_id from Our_project_blog_answers) ORDER BY `follow` DESC;")
        
        # zip the raw results into a dict
        columns = [column[0] for column in cursor.description]
        rows = cursor.fetchall()
        questions_represent_by_dict = []
        for row in rows:
            questions_represent_by_dict.append(dict(zip(columns, row)))

        data = {}
        for i in range(0, len(questions_represent_by_dict)):

            # get the id of question blog
            question_id = questions_represent_by_dict[i]['id']

            # fectch the pic's url according to the question blog's id
            url = picture.objects.filter(question = question_id).values()[0]['url']

            isliked = 0
            if (user_like_question.objects.filter(question_id = question_id, id = userid)):
                isliked = 1

            # check whether the current user has followed this blog_question. If the current user has followed this blog, return isfollowed = 1
            isfollowed = 0
            if (user_follow_question.objects.filter(question_id = question_id, id = userid)):
                isfollowed = 1

            # put all the necessary information into the dict
            temp = questions_represent_by_dict[i]

            if (temp['content_format'] == "Markdown"):
                content = temp["content"]
                raw_content = get_raw(get_HTML(content))
            else:
                raw_content = temp['content']

            if (len(raw_content) > 140):
                raw_content = raw_content[0:140] + "..."

            temp['url'] = url
            temp['isliked'] = isliked
            temp['isfollowed'] = isfollowed
            temp['content'] = raw_content
            data['blog'+str(i+i)] = temp

        return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')


# allow user to like a question/answer
def like(request):
    data = {
        'ok': 0
    }
    try:
        if request.method == 'POST':
            
            Question_or_Answer = request.POST['type']
            username = request.POST['username']
            target_id = request.POST['id']
            user_id = User.objects.filter(username=username).values()[0]['id']
            if (int(Question_or_Answer)):    # means the id belong to an answer
    
                already_like = user_like_answer.objects.filter(id= user_id, answer_id = target_id).count()
                if (already_like):     # if already like, then dislike
                    user_like_answer.objects.filter(id= user_id, answer_id = target_id).delete()

                    change_amount_of_like_or_follow(target_id, Question_or_Answer = 0, follow_or_like = 0, add_or_reduce = 0)
                else:
                    user_like_answer.objects.create(id= user_id, answer_id = target_id)

                    change_amount_of_like_or_follow(target_id, Question_or_Answer = 0, follow_or_like = 0, add_or_reduce = 1)
            else:                       # means the id belong to a question

                already_like = user_like_question.objects.filter(id= user_id, question_id = target_id).count()
                if (already_like):     # if already like, then dislike
                    user_like_question.objects.filter(id= user_id, question_id = target_id).delete()

                    change_amount_of_like_or_follow(target_id, Question_or_Answer = 1, follow_or_like = 0, add_or_reduce = 0)
                else:
                    user_like_question.objects.create(id= user_id, question_id = target_id)

                    change_amount_of_like_or_follow(target_id, Question_or_Answer = 1, follow_or_like = 0, add_or_reduce = 1)

            data['ok'] = 1
    except:
        pass

    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')
            

    

# allow user to follow a question
def follow(request):
    data = {
        'ok': 0
    }

    if request.method == 'POST':
        
        username = request.POST['username']
        target_id = request.POST['id']
        user_id = User.objects.filter(username=username).values()[0]['id']

        already_like = user_follow_question.objects.filter(id= user_id, question_id = target_id).count()
        if (already_like):     # if already like, then dislike
            user_follow_question.objects.filter(id= user_id, question_id = target_id).delete()
            change_amount_of_like_or_follow(target_id, Question_or_Answer = 1, follow_or_like = 1, add_or_reduce = 0)
        else:
            user_follow_question.objects.create(id= user_id, question_id = target_id)
            change_amount_of_like_or_follow(target_id, Question_or_Answer = 1, follow_or_like = 1, add_or_reduce = 1)

        data['ok'] = 1

    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')


def change_amount_of_like_or_follow(target_id, Question_or_Answer, follow_or_like, add_or_reduce):
    if (follow_or_like):  # if it is follow
        num_follow = Blog_Questions.objects.filter(id=target_id).values()[0]
        num_hot = Blog_Questions.objects.filter(id=target_id).values()[0]                  
        update_blog = Blog_Questions.objects.get(id=target_id)
        if (add_or_reduce):
            update_blog.follow = num_follow['follow'] + 1
            update_blog.hot = num_hot['hot'] + 1
        else:
            update_blog.follow = num_follow['follow'] - 1
            update_blog.hot = num_hot['hot'] - 1
        update_blog.save()
    else:     # if it is like
        if (Question_or_Answer):      # if this is a question
            num_like = Blog_Questions.objects.filter(id=target_id).values()[0]
            num_hot = Blog_Questions.objects.filter(id=target_id).values()[0]                  
            update_blog = Blog_Questions.objects.get(id=target_id)
            if (add_or_reduce):       # if add
                update_blog.like = num_like['like'] + 1
                update_blog.hot = num_hot['hot'] + 1
            else:     # reduce
                update_blog.like = num_like['like'] - 1
                update_blog.hot = num_hot['hot'] - 1
            update_blog.save()
        else:                         # if this is an answer
            num_like = Blog_Answers.objects.filter(id=target_id).values()[0]                 
            update_blog = Blog_Answers.objects.get(id=target_id)
            if (add_or_reduce):       # if add
                update_blog.like = num_like['like'] + 1
            else:     # reduce
                update_blog.like = num_like['like'] - 1
            update_blog.save()

def uploadProfile(request):

    username = request.POST['username']
    profile = request.FILES.get('profile')
    profile_dir1 = '../profiles/' + request.POST['id'] + '.jpg'
    f = open(profile_dir1, 'wb')
    for line in profile.chunks():
        f.write(line)
    f.close()
    data = {
        'profile_name': request.POST['id'] + '.jpg'
    }

    # 判断是否改用户已经有头像了
    target_user = User.objects.filter(username = username).values()[0]
    print(target_user)
    photo_url = target_user['photo']
    if (photo_url):    # 用户有旧的头像, 则在服务器上删掉
        prefix_string = ''
        for i in range(0, len(photo_url)):
            prefix_string += photo_url[i]
            if (prefix_string == 'http://175.178.34.84/'):
                break
        delete_url = '../' + photo_url[i+1:] 
        os.remove(delete_url)

    # 将用户头像的url更新到数据库中
    update_user = User.objects.get(username = username)
    update_user.photo = 'http://175.178.34.84/profiles/'+ request.POST['id'] + '.jpg'
    update_user.save()

    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

def getProfile(request):
    username = request.POST['username']
    
    target_user = User.objects.filter(username = username).values()

    photo_url = target_user[0]['photo']

    data = {}
    if (photo_url): # 头像不为空
        data['url'] = photo_url
    else:
        data['url'] = ''
    
    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

'''
    Receive the POST request about the group_name, username, subgroup_name
    First, return the blogs related to this group.
'''
def getGroup(request):
    group_name = request.POST['group_name']
    sub_group_name = request.POST['sub_group_name']
    username = request.POST['username']
    user_id = User.objects.filter(username=username).values()[0]['id']
    
    data = {}

    sub_group_id = sub_group.objects.filter(group_name = group_name, sub_group_name = sub_group_name).values()[0]['id']

    questions = Blog_Questions.objects.filter(group_type = group_name, sub_group_type = sub_group_id).order_by('-hot').values()
    
    for i in range(0, len(questions)):
        question_id = questions[i]['id']

        # check whether the current user has liked this blog_question. If the current user has liked this blog, return isliked = 1
        isliked = 0
        if (user_like_question.objects.filter(question_id = question_id, id = user_id)):
            isliked = 1

        # check whether the current user has followed this blog_question. If the current user has followed this blog, return isfollowed = 1
        isfollowed = 0
        if (user_follow_question.objects.filter(question_id = question_id, id = user_id)):
            isfollowed = 1

        # getting the url of picture of the corresponding blog
        url = picture.objects.filter(question = question_id).values()[0]['url']

        # getting the amount of answers regarding to this questions
        amount_of_answers = Blog_Answers.objects.filter(question_id = question_id).count()

        # getting the sub_group_name according to the sub_group_type
        sub_group_name = sub_group.objects.filter(id = questions[i]["sub_group_type"]).values()[0]["sub_group_name"]

        if (questions[i]['content_format'] == "Markdown"):
            content = questions[i]["content"]
            raw_content = get_raw(get_HTML(content))
        else:
            raw_content = questions[i]["content"]

        if (len(raw_content) > 140):
            raw_content = raw_content[0:140] + "..."

        # put the url, whether user has liked/followed the blog into data, preparing to be sent to frontend
        temp = questions[i]
        temp['isliked'] = isliked
        temp['isfollowed'] = isfollowed
        temp['url'] = url
        temp['content'] = raw_content
        temp['sub_group_name'] = sub_group_name
        temp['amount_of_answers'] = amount_of_answers
        data['blog'+str(i+1)] = temp
            
    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')


'''
    Receive the POST request about the username and group_name
    If the user has followed, then unfollow. Vice Verse
    Store/Delete the "user follow group" info into DB, add/delete the number of follow of Group by 1
    return {ok: 1} if the  
'''
def followGroup(request):
    username = request.POST['username']
    group_name = request.POST['group_name']

    # get the corresponding user id
    user_id = User.objects.filter(username=username).values()[0]['id']
    
    if (user_follow_group.objects.filter(id = user_id, group_name = group_name)):
        user_follow_group.objects.filter(id= user_id, group_name = group_name).delete()
        num_follow = Group.objects.filter(group_name = group_name).values()[0]                  
        update_group = Group.objects.get(group_name= group_name)
        update_group.amount_of_follows = num_follow['amount_of_follows'] - 1
        update_group.save()
    else:
        user_follow_group.objects.create(id= user_id, group_name = group_name)
        num_follow = Group.objects.filter(group_name = group_name).values()[0]                  
        update_group = Group.objects.get(group_name= group_name)
        update_group.amount_of_follows = num_follow['amount_of_follows'] + 1
        update_group.save()
    data = {}
    data["ok"] = 1

    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

'''
    Receive the POST request about the username
    Return all the groups, as well as each's description, url of picture, 
    number of follows, and whether the current user follow
    default own = 0 means return all the groups, own = 1 means only return the groups that current user follows
'''
def groups(request, own = 0):
    data = {}
    username = request.POST['username']
    user_id = User.objects.filter(username=username).values()[0]['id']

    groups = Group.objects.values()

    n_group = 0
    for i in range(0, len(groups)):
        group = groups[i]
        group_name = group["group_name"]

        # get the url of picture of this group
        url = picture.objects.filter(group_name = group_name).values()[0]['url']
        
        # check whether the current user has followed this group
        isFollowed = 0
        if (user_follow_group.objects.filter(id = user_id, group_name = group_name)):
            isFollowed = 1
        else: 
            if (own == 1):
                continue

        temp = group
        temp["isFollowed"] = isFollowed
        temp["url"] = url

        # get the corresponding sub-groups' name of this group, and assemble them into the return data
        sub_groups = sub_group.objects.filter(group_name = group_name).values()
        name_of_subgroups = []
        sub_groups_names = {}
        for j in range(0, len(sub_groups)):
            sub_groups_names["subgroup" + str(j+1)] = sub_groups[j]["sub_group_name"]

        temp["sub_groups"] = sub_groups_names
        data["group" + str(n_group+1)] = temp
        n_group += 1

    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')


'''
    Inherit from groups(),
    return only the groups that the current user is following
'''
def MyGroups(request): 

    response = groups(request, own = 1)
    return response


'''
    Gives the question id and username, 
    return all the contents of questions. Including convert the mardown format into the HTML one. 
'''
def GetQuestions(request):
    
    question_id = request.POST["question_id"]
    username = request.POST["username"]
    userid = User.objects.filter(username=username).values()[0]['id']
    
    question = Blog_Questions.objects.filter(id = question_id).values()[0]

    # check whether the current user has liked this blog_question. If the current user has liked this blog, return isliked = 1
    isliked = 0
    if (user_like_question.objects.filter(question_id = question_id, id = userid)):
        isliked = 1

    # check whether the current user has followed this blog_question. If the current user has followed this blog, return isfollowed = 1
    isfollowed = 0
    if (user_follow_question.objects.filter(question_id = question_id, id = userid)):
        isfollowed = 1

    # getting the url of picture of the corresponding blog
    pics = picture.objects.filter(question = question_id).values()
    pic_urls = {}
    for i in range(0, len(pics)):
         pic_urls["url" + str(1+i)] = pics[i]["url"]

    # find the files attached to this question
    files = file.objects.filter(corresponding_question = question_id).values()
    file_urls = {}
    for i in range(0, len(files)):
        file_urls["url" + str(1+i)] = files[i]["url"]

    # getting the amount of answers regarding to this questions
    amount_of_answers = Blog_Answers.objects.filter(question_id = question_id).count()

    content = question["content"]
    if (question["content_format"] == "Markdown"):
        html_content = get_HTML(content)
    else:
        html_content = content

    # put the url, whether user has liked/followed the blog into data, preparing to be sent to frontend
    temp = question
    temp['content'] = html_content
    temp['isliked'] = isliked
    temp['isfollowed'] = isfollowed
    temp['pic_urls'] = pic_urls
    temp['file_urls'] = file_urls
    temp['amount_of_answers'] = amount_of_answers

    data = temp
    
    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

'''
    Gives the content formated by markdown,
    return the content formated by HTML
'''
def get_HTML(md_content):
    HTML_content = markdown.markdown(md_content, 
            extensions = [
                'markdown.extensions.extra',
                'markdown.extensions.codehilite',
            ])
    return HTML_content

'''
    Get the HTML format of content, return the raw data. 
'''
def get_raw(HTML_content):
    raw_data = ""
    deleting = False
    stop_point = 0
    newline = False
    for i in range(0, len(HTML_content)):
        if (HTML_content[i] == "<"):
            if (deleting == False):
                deleting = True
                stop_point = i
            else:
                deleting = False
                raw_data += HTML_content[stop_point:i-1]
        if (deleting == False):
            if (HTML_content[i] == "\n"):
                if (newline == False):
                    newline = True
                else:
                    continue  
            else:
                newline = False
            raw_data += HTML_content[i]
        if (HTML_content[i] == ">"):
            if (deleting == True):
                deleting = False

    return raw_data

'''
    Given the username, Question ID,
    gives all the contents related to this question.
    Specially, maybe there will be answers which answer to another answer, it should be also included
'''
def GetAnswers(request):

    data = {}

    username = request.POST['username']
    userid = User.objects.filter(username=username).values()[0]['id']

    question_id = request.POST['question_id']

    Answers = Blog_Answers.objects.filter(question_id = question_id).order_by("-id").values()
    index_root_answer = Blog_Answers.objects.filter(question_id = question_id, father_answer_id = None).count()

    fathers = []
    for i in range(0, len(Answers)):
        answer = Answers[i]
        answer_id = answer['id']

        # check whether the current user has liked this blog_question. If the current user has liked this blog, return isliked = 1
        isliked = 0
        if (user_like_answer.objects.filter(answer_id = answer_id, id = userid)):
            isliked = 1

        # getting the url of picture of the corresponding blog
        pics = picture.objects.filter(answer = answer_id).values()
        pic_urls = {}
        for i in range(0, len(pics)):
            pic_urls["url" + str(1+i)] = pics[i]["url"]

        # find the files attached to this question
        files = file.objects.filter(corresponding_answer = answer_id).values()
        file_urls = {}
        for i in range(0, len(files)):
            file_urls["url" + str(1+i)] = files[i]["url"]

        content = answer["content"]
        if (answer["content_format"] == "Markdown"):
            html_content = get_HTML(content)
        else:
            html_content = content

        # according to the author id, return the author's profile url and username
        author_id = answer["author_id"]
        author_name = User.objects.filter(id = author_id).values()[0]['username']
        profile_url = User.objects.filter(id = author_id).values()[0]['photo']

        # put the url, whether user has liked/followed the blog into data, preparing to be sent to frontend
        answer['content'] = html_content
        answer['isliked'] = isliked
        answer['pic_urls'] = pic_urls
        answer['file_urls'] = file_urls
        answer['author_name'] = author_name
        answer['author_profile_url'] = profile_url
        answer['Children'] = {}

        if (answer_id in fathers):
            # then adopt its children
            children = Blog_Answers.objects.filter(question_id = question_id, father_answer_id = answer_id).order_by("-id").values()
            father = answer
            for j in range(0, len(children)):
                child_name = "Answer" + str(children[j]["id"])
                child = data[child_name]
                Children = answer["Children"]
                Children["Child" + str(len(children)-j)] = child
                data.pop(child_name)
            father["Children"] = Children
            if (answer["father_answer_id"] == None):
                data["root"+str(index_root_answer)] = father
                index_root_answer -= 1
            else:
                data["Answer" + str(answer_id)] = father
            fathers.remove(answer_id)
        else:
            if (answer["father_answer_id"] == None):
                data["root"+str(index_root_answer)] = answer
                index_root_answer -= 1
            else:
                data["Answer" + str(answer_id)] = answer        
        if (answer["father_answer_id"] != None and (answer["father_answer_id"] not in fathers)):
            fathers.append(answer["father_answer_id"])
            
    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')


'''
    Reveice piece of code, compile it and run it on internet,
    return the result back
'''
def run_code(request):
    source = request.POST['source_code']
    lang = request.POST['lang']

    accessToken = '1963c8460eedcdf0d6aa233a8c6e1021'
    endpoint = 'a3e69f92.compilers.sphere-engine.com'

    client = CompilersClientV4(accessToken, endpoint)

    compiler = 116   # default python
    if (lang == "Python"):
        compiler = 116
    elif (lang == "Assembler"):
        compiler = 45
    elif (lang == "C"):
        compiler = 11
    elif (lang == "C#"):
        compiler = 86
    elif (lang == "C++"):
        compiler = 1
    elif (lang == "Fortran"):
        compiler = 5
    elif (lang == "Go"):
        compiler = 114
    elif (lang == "Java"):
        compiler = 10
    elif (lang == "R"):
        compiler = 117
    elif (lang == "Rust"):
        compiler = 93

    input = '111'

    response = client.submissions.create(source, compiler, input)

    task_id = response.get("id")
    response = client.submissions.get(task_id)

    executing_status = response.get("executing")

    while (executing_status):
        response = client.submissions.get(task_id)
        executing_status = response.get("executing")

    print(response)
    try:
        uri=response.get("result").get("streams").get("output").get('uri')
    except:
        try:
            uri=response.get("result").get("streams").get("error").get('uri')
        except:
            uri=response.get("result").get("streams").get("cmpinfo").get('uri')
    contents = urllib.request.urlopen(uri).read().decode('utf-8')

    data = {}
    data["result"] = contents

    return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')
