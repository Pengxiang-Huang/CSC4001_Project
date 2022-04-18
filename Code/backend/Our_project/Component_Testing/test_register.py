from .. import views
import random
import json
import requests

class request:
    POST = {}
    GET = {}
    session = {}
    method = "POST"
    def __init__(self, method):
        self.POST = {}
        self.GET = {}
        self.method = method

# 1. test with normal inputs   => => expect isRegister == 0 and status_code == 200
def normal_test1():
    req = request("POST")
    req.POST["username"] = str(random.randint(0, 1000000))
    req.POST["email"] = "123456789@link.cuhk.edu.cn"
    req.POST["password"] = "123"
    response = views.register(req)
    json_data = json.loads(response.content)
    isRegister = json_data['isRegister']
    if (response.status_code == 200 and isRegister == 1):
        return 1
    return 0

# 2. test with existing username => expect isRegister == 0
def same_name_test():   
    req = request("POST")
    req.POST["username"] = "qpr"
    req.POST["email"] = "123456789@link.cuhk.edu.cn"
    req.POST["password"] = "123"
    response = views.register(req)
    json_data = json.loads(response.content)
    isRegister = json_data['isRegister']
    if (response.status_code == 200 and isRegister == 0):
        return 1
    return 0

# 3. test GET request  => expect isRegister == 0
def wrong_request_test():
    req = request("GET")
    req.POST["email"] = "123456789@link.cuhk.edu.cn"
    req.POST["password"] = "123"
    response = views.register(req)
    json_data = json.loads(response.content)
    isRegister = json_data['isRegister']
    if (response.status_code == 200 and isRegister == 0):
        return 1
    return 0


def test():
    if not (normal_test1() == 1):
        return 0
    if not (same_name_test() == 1):
        return 0
    if not (wrong_request_test() == 1):
        return 0

    return 1