from .. import views
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


# click like first then click follow
def normal_test1():
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
    return 1

# click like twice on a question, it will first like this question then unlike this question
def normal_test2():
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
    req.POST['type'] = 0

    response = views.like(req)
    json_data = json.loads(response.content)
    data = json_data
    if not (response.status_code == 200 and data['ok'] == 1):
        return 0
    return 1

# click like twice on an answer, it will first like this question then unlike this question
def normal_test3():
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
    return 1

# click follow twice on an question, it will first follow this question then unfollow this question
def normal_test4():
    req = request("POST")
    req.POST["username"] = "qpr"
    req.POST["id"] = 1
    req.POST['type'] = 0

    response = views.follow(req)
    json_data = json.loads(response.content)
    data = json_data
    if not (response.status_code == 200 and data['ok'] == 1):
        return 0

    req.POST["username"] = "qpr"
    req.POST["id"] = 1
    req.POST['type'] = 0

    response = views.follow(req)
    json_data = json.loads(response.content)
    data = json_data
    if not (response.status_code == 200 and data['ok'] == 1):
        return 0
    return 1


def test():
    if not (normal_test1() == 1):
        return 0
    if not (normal_test2() == 1):
        return 0
    if not (normal_test3() == 1):
        return 0
    if not (normal_test4() == 1):
        return 0

    return 1
