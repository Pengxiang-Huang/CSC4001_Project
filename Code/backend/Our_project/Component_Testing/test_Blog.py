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


# normal test => expect return with status_code == 200
def normal_test1():
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
    return 1



def test():
    if not (normal_test1() == 1):
        return 0

    return 1
