from .. import views
import json
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


# normal test reset Username. => expect to get UserName Reset successfully!
def normal_test1():
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST['type'] = "Reset Username"
    req.POST['newVal'] = "temp"

    response = views.update(req)
    req.POST['username'] = "temp"
    req.POST['type'] = "Reset Username"
    req.POST['newVal'] = "qpr"
    response = views.update(req)

    if (response.status_code == 200 and b'UserName Reset successfully!' == response.content):
        return 1
    return 0

# normal test reset Password. => expect to get Password Reset successfully!
def normal_test2():
    new_password = "Q@@pr294118"

    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST['type'] = "Reset Password"
    req.POST['newVal'] = "12345"

    response = views.update(req)
    req.POST['username'] = "qpr"
    req.POST['type'] = "Reset Password"
    req.POST['newVal'] = new_password
    response = views.update(req)

    if not (response.status_code == 200 and b'Password Reset successfully!' == response.content):
        return 0

    # verify by login use the new Password
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST["password"] = new_password
    response = views.login(req)
    if (response.status_code == 200):
        return 1

    return 0

def test_invalid():   # change to existed username
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST['type'] = "Reset Username"
    req.POST['newVal'] = "QinPR"
    response = views.update(req)

    if (response.status_code == 200 and b'UserName has been taken' == response.content):
        return 1
    return 0


def test():
    if not (normal_test1() == 1):
        return 0
    if not (normal_test2() == 1):
        return 0
    if not (test_invalid() == 1):
        return 0
    return 1
