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


# normal test with valid input. => expect to redirect to other page
def normal_test1():
    req = request("POST")
    req.session['username'] = "qpr"
    req.session["uid"] = "123"
    response = views.logout(req)
    if (response.status_code == 302):
        return 1
    return 0

# test with no sessions => expect to redict to other page
def with_no_sessions_test():
    req = request("POST")
    response = views.logout(req)
    if (response.status_code == 302):
        return 1
    return 0

# test with no sessions => expect to redict to other page
def with_cookies_test():
    req = request("POST")
    req.COOKIES['username'] = 'qpr'
    req.COOKIES['uid'] = 1
    response = views.logout(req)
    if (response.status_code == 302):
        return 1
    return 0



def test():
    if not (normal_test1() == 1):
        return 0
    if not (with_no_sessions_test() == 1):
        return 0
    if not (with_cookies_test() == 1):
        return 0
    return 1
