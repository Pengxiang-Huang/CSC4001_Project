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


# normal test => expect return with status_code == 200
def normal_test1():
    req = request("POST")
    req.POST["title"] = "How to be a perfect test engineer?"
    req.POST["author_name"] = "QinPR"
    req.POST["group_type"] = "CSC4001"
    req.POST["sub_group_type"] = "Project"
    req.POST["content"] = "Can anybody tell me how to write test suites?"
    req.POST["code"] = "println!("")"
    req.POST["lang"] = "Rust"
    
    response = views.setQuestion(req)
    if (response.status_code == 200):
        return 1
    return 0

# invalid input with no title
def no_title():
    req = request("POST")
    req.POST["author_name"] = "QinPR"
    req.POST["group_type"] = "CSC4001"
    req.POST["sub_group_type"] = "Project"
    req.POST["content"] = "Can anybody tell me how to write test suites?"
    req.POST["code"] = "println!("")"
    req.POST["lang"] = "Rust"
    
    response = views.setQuestion(req)
    if (response.status_code == 200 and b'Receive no tile!' == response.content):
        return 1
    return 0

# invalid input with no author name
def no_name():
    req = request("POST")
    req.POST["title"] = "How to be a perfect test engineer?"
    req.POST["group_type"] = "CSC4001"
    req.POST["sub_group_type"] = "Project"
    req.POST["content"] = "Can anybody tell me how to write test suites?"
    req.POST["code"] = "println!("")"
    req.POST["lang"] = "Rust"
    
    response = views.setQuestion(req)
    if (response.status_code == 200 and b'No Such Username!' == response.content):
        return 1
    return 0

# invalid input with no group_type and sub_group_type
def invalid_group_sub_group():
    req = request("POST")
    req.POST["title"] = "How to be a perfect test engineer?"
    req.POST["author_name"] = "QinPR"
    req.POST["content"] = "Can anybody tell me how to write test suites?"
    req.POST["code"] = "println!("")"
    req.POST["lang"] = "Rust"
    
    response = views.setQuestion(req)
    json_data = json.loads(response.content)
    data = json_data
    if (response.status_code == 200 and data['ok'] == 0):
        return 1
    return 0

# invalid input without content
def no_content():
    req = request("POST")
    req.POST["title"] = "How to be a perfect test engineer?"
    req.POST["author_name"] = "QinPR"
    req.POST["group_type"] = "CSC4001"
    req.POST["sub_group_type"] = "Project"
    
    response = views.setQuestion(req)
    if (response.status_code == 200 and b'Receive empty content!' == response.content):
        return 1
    return 0


def test():
    if not (normal_test1() == 1):
        return 0
    if not (no_title() == 1):
        return 0
    if not (no_name() == 1):
        return 0
    if not (invalid_group_sub_group() == 1):
        return 0
    if not (no_content() == 1):
        return 0

    return 1
