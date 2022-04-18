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

# normal test with valid input. => expect status == 200
def normal_test1():
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST["password"] = "Q@@pr294118"
    response = views.login(req)
    if (response.status_code == 200):
        return 1
    return 0

# normal test with wrong password. => expect status != 200
def wrong_password_test():
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST["password"] = "wrong_password"
    response = views.login(req)
    if (response.status_code == 200 and b'Username or Password Error. Please check!' == response.content):
        return 1
    return 0

# redirect because of session exists.  => expect status = 302
def valid_with_sessions_test():
    req = request("GET")
    req.session['username'] = "1"
    req.session["uid"] = "2"
    response = views.login(req)
    if (response.status_code == 302):
        return 1
    return 0

# login with valid cookie  => expect statuts == 304
def with_valid_cookies():
    req = request("GET")
    req.COOKIES['username'] = "1"
    req.COOKIES["uid"] = "3"
    response = views.login(req)
    if (response.status_code == 302):
        return 1
    return 0


def test():
    if not (normal_test1() == 1):
        return 0
    if not (wrong_password_test() == 1):
        return 0
    if not (valid_with_sessions_test() == 1):
        return 0
    if not (with_valid_cookies() == 1):
        return 0
    return 1
