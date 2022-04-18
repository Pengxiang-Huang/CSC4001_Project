from . import views
import json
import random
import requests

class request:
    POST = {}
    GET = {}
    session = {}
    COOKIES = {}
    method = "POST"
    def __init__(self, method):
        self.POST = {}
        self.GET = {}
        self.method = method

# login -> logout -> login -> mainpage -> getGroups -> click like on question -> click follow -> Postquestion -> GetBlogs -> click like on answer
def a_journey():

    ### fist login then logout then login 
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST["password"] = "Q@@pr294118"
    response = views.login(req)
    if (response.status_code == 200):
        req = request("POST")
        req.session['username'] = "qpr"
        req.session["uid"] = "1"
        resp = views.logout(req)
        if (resp.status_code != 302):
            return 0
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST["password"] = "Q@@pr294118"
    response = views.login(req)

    ### then get mainpage
    req = request("POST")
    req.POST["username"] = "qpr"

    response = views.main_page(req)
    json_data = json.loads(response.content)
    data = json_data

    index = random.randint(1, len(data)-1)
    blog_test = data['blog' + str(index)]    # verify 1 blog's data randomly
    if not (blog_test):
        return 0
    isLiked = blog_test["isliked"]
    if (isLiked == None):
        return 0
    isfollowed = blog_test['isfollowed']
    if (isfollowed == None):
        return 0
    url = blog_test['url']
    if (url == None):
        return 0
    content = blog_test['content']
    if not (content):
        return 0
    amount_of_answers = blog_test['amount_of_answers']
    if (amount_of_answers == None):
        return 0

    ### then click like on specific question
    req = request("POST")
    req.POST["username"] = "qpr"
    req.POST["id"] = 1
    req.POST['type'] = 0

    response = views.like(req)
    json_data = json.loads(response.content)
    data = json_data
    if not (response.status_code == 200 and data['ok'] == 1):
        return 0

    req.POST["username"] = "qpr"
    req.POST["id"] = 1
    req.POST['type'] = 1

    response = views.follow(req)
    json_data = json.loads(response.content)
    data = json_data
    if not (response.status_code == 200 and data['ok'] == 1):
        return 0

    ### then getGroups 拿到分区内容
    req = request("POST")
    req.POST["username"] = "QinPR"
    req.POST["group_name"] = "CSC4001"
    req.POST["sub_group_name"] = "Project"

    response = views.getGroup(req)
    json_data = json.loads(response.content)
    data = json_data

    index = random.randint(1, len(data)-1)
    blog_test = data['blog' + str(index)]    # verify 1 blog's data randomly
    if not (blog_test):
        return 0
    isLiked = blog_test["isliked"]
    if (isLiked == None):
        return 0
    isfollowed = blog_test['isfollowed']
    if (isfollowed == None):
        return 0
    url = blog_test['url']
    if (url == None):
        return 0
    content = blog_test['content']
    if not (content):
        return 0
    amount_of_answers = blog_test['amount_of_answers']
    if (amount_of_answers == None):
        return 0
    sub_group_name = blog_test['sub_group_name']
    if (sub_group_name == None):
        return 0

    ### then getMyFollows
    req = request("POST")
    req.POST["username"] = "QinPR"

    response = views.my_follow(req)
    json_data = json.loads(response.content)
    data = json_data


    index = random.randint(1, len(data)-1)
    blog_test = data['blog' + str(index)]    # verify 1 blog's data randomly
    if not (blog_test):
        return 0
    isLiked = blog_test["isliked"]
    if (isLiked == None):
        return 0
    isfollowed = blog_test['isfollowed']
    if (isfollowed == None):
        return 0
    url = blog_test['url']
    if (url == None):
        return 0
    content = blog_test['content']
    if not (content):
        return 0
    amount_of_answers = blog_test['amount_of_answers']
    if (amount_of_answers == None):
        return 0

    ### then get post a question
    req = request("POST")
    req.POST["title"] = "How to be a perfect test engineer?"
    req.POST["author_name"] = "QinPR"
    req.POST["group_type"] = "CSC4001"
    req.POST["sub_group_type"] = "Project"
    req.POST["content"] = "Can anybody tell me how to write test suites?"
    req.POST["code"] = "println!("")"
    req.POST["lang"] = "Rust"
    
    response = views.setQuestion(req)
    if (response.status_code != 200):
        return 1


    ### then get into one blog
    req_question = request("POST")
    req_question.POST["username"] = "QinPR"
    req_question.POST["question_id"] = 1

    response = views.GetQuestions(req_question)
    if (response.status_code != 200):
        return 0


    req_answers = request("POST")
    req_answers.POST["username"] = "QinPR"
    req_answers.POST["question_id"] = 1
    response = views.GetAnswers(req_answers)

    if (response.status_code != 200):
        return 0

    #### finally, click like on the answer in blog
    req = request("POST")
    req.POST["username"] = "qpr"
    req.POST["id"] = 1
    req.POST['type'] = 1

    response = views.like(req)
    json_data = json.loads(response.content)
    data = json_data
    if not (response.status_code == 200 and data['ok'] == 1):
        return 0

    req.POST["username"] = "qpr"
    req.POST["id"] = 1
    req.POST['type'] = 1

    response = views.like(req)
    json_data = json.loads(response.content)
    data = json_data
    if not (response.status_code == 200 and data['ok'] == 1):
        return 0
    

    ### in the end, log-out

    req = request("POST")
    req.session['username'] = "qpr"
    req.session["uid"] = "123"
    response = views.logout(req)
    if (response.status_code != 302):
        return 0
    
    return 1




def test():
    if not (a_journey() == 1):
        return "FAILED"
    return "PASS"
