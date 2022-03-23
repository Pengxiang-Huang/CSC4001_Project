
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import HttpResponse
from django.core.mail import send_mail
import json
from django.db import connection    # allow Django to use the original SQL statements
from datetime import date, datetime

from .models import User
from .models import Blog_Questions
from .models import picture
from .models import Blog_Answers
from .models import user_like_question
from .models import user_follow_question
from .models import user_follow_group
from .models import user_like_answer
from .models import Group
import hashlib

# 重写python的datetime类型
class ComplexEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.strftime('%Y-%m-%d %H:%M:%S')
        elif isinstance(obj, date):
            return obj.strftime('%Y-%m-%d')
        else:
            return json.JSONEncoder.default(self, obj)


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
            return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')
        
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
            return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

        #免登录一天 session
        request.session['username'] = username
        request.session['uid'] = user.id
        #TODO 修改session储存时间为一天


        #return successful information
        return HttpResponse(json.dumps(data , cls=ComplexEncoder), content_type='application/json')

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

# 根据hot排序，返回5个当前热门的问题
def main_page(request):
    
    if request.method == 'POST':
        # getting the username from POST request
        username = request.POST['username']

        userid = User.objects.filter(username = username).values()[0]['id']

        # getting the blogs, order by 'hot'
        hot_blogs = Blog_Questions.objects.order_by('-hot').values()
        data = {}
        for i in range(0,5):
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

            # put the url, whether user has liked/followed the blog into data, preparing to be sent to frontend
            temp = hot_blogs[i]
            temp['isliked'] = isliked
            temp['isfollowed'] = isfollowed
            temp['url'] = url
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
            temp['url'] = url
            temp['isliked'] = isliked
            temp['isfollowed'] = isfollowed
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
            temp['url'] = url
            temp['isliked'] = isliked
            temp['isfollowed'] = isfollowed
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



def uploadProfile():
    return 0

def getProfile():
    return 0