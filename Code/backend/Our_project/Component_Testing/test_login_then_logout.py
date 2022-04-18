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

# normal test with valid input: first login then logout, 
# expect finnaly been redirect to login page and return 302
# with sessions
def normal_test1():
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST["password"] = "Q@@pr294118"
    response = views.login(req)
    if (response.status_code == 200):
        req = request("POST")
        req.session['username'] = "qpr"
        req.session["uid"] = "1"
        resp = views.logout(req)
        if (resp.status_code == 302):
            return 1
    return 0

# normal test with valid input: first login then logout, 
# expect finnaly been redirect to login page and return 302
# with cookies
def normal_test2():
    req = request("POST")
    req.POST['username'] = "qpr"
    req.POST["password"] = "Q@@pr294118"
    response = views.login(req)
    if (response.status_code == 200):
        req = request("POST")
        req.COOKIES['username'] = "qpr"
        req.COOKIES["uid"] = "1"
        resp = views.logout(req)
        if (resp.status_code == 302):
            return 1
    return 0




def test():
    if not (normal_test1() == 1):
        return 0
    if not (normal_test2() == 1):
        return 0
    return 1
