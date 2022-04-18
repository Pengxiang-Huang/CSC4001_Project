from .Unit_Testing import test_code
from .Unit_Testing import test_login
from .Unit_Testing import test_logout
from .Unit_Testing import test_update
from .Unit_Testing import test_sendEmail
from .Unit_Testing import test_SetQuestion
from .Unit_Testing import test_SearchQuestion
from .Unit_Testing import test_my_follow
from .Unit_Testing import test_my_group
from .Unit_Testing import test_unAnswered
from .Unit_Testing import test_like
from .Unit_Testing import test_follow
from .Unit_Testing import test_getGroup
from .Unit_Testing import test_followGroup
from .Unit_Testing import test_groups
from .Unit_Testing import test_MyGroups
from .Unit_Testing import test_GetQuestions
from .Unit_Testing import test_run_code
from .Unit_Testing import test_MyBlogs

class request:
    POST = {}
    GET = {}
    def __init__(self):
        self.POST = {}
        self.GET = {}

def test():
    data = {}
    
    # 1. test views.code()
    if (test_code.test() == 1):
        data["test-code()"] = "PASS"
    else:
        data["test-code()"] = "FAILED"
    

    # 2. test views.login()
    if (test_login.test() == 1):
        data["test-login()"] = "PASS"
    else:
        data["test-login()"] = "FAILED"

    # 3. test views.lougout()
    if (test_logout.test() == 1):
        data["test-out()"] = "PASS"
    else:
        data["test-out()"] = "FAILED"

    # 4. test views.update()
    if (test_update.test() == 1):
        data["test-update()"] = "PASS"
    else:
        data["test-update()"] = "FAILED"

    # 5. test sendEmail()
    if (test_sendEmail.test() == 1):
        data["test-sendEmail()"] = "PASS"
    else:
        data["test-sendEmail()"] = "FAILED"

    # 6. test SetQuestion()
    if (test_SetQuestion.test() == 1):
        data["test_SetQuestion()"] = "PASS"
    else:
        data["test_SetQuestion()"] = "FAILED"

    # 7. test SearchQuestion()
    if (test_SearchQuestion.test() == 1):
        data["test SearchQuestion()"] = "PASS"
    else:
        data["test SearchQuestion()"] = "FAILED"


    # 9. test my_follow()
    if (test_my_follow.test() == 1):
        data["test my_follow()"] = "PASS"
    else:
        data["test my_follow()"] = "FAILED"

    # 10. test my_group()
    if (test_my_group.test() == 1):
        data["test my_group()"] = "PASS"
    else:
        data["test my_group()"] = "FAILED"

    # 11 test unAnswered()
    if (test_unAnswered.test() == 1):
        data["test unAnswered()"] = "PASS"
    else:
        data["test unAnswered()"] = "FAILED"

    # 12 test like
    if (test_like.test() == 1):
        data["test like()"] = "PASS"
    else:
        data["test like()"] = "FAILED"

    # 13 test follow
    if (test_follow.test() == 1):
        data["test follow()"] = "PASS"
    else:
        data["test follow()"] = "FAILED"

    # 14 test getGroup()
    if (test_getGroup.test() == 1):
        data["test getGroup()"] = "PASS"
    else:
        data["test getGroup()"] = "FAILED"

    # 15 test getGroup()
    if (test_groups.test() == 1):
        data["test groups()"] = "PASS"
    else:
        data["test groups()"] = "FAILED"
    
    # 16 test MyGroups()
    if (test_MyGroups.test() == 1):
        data["test MyGroups()"] = "PASS"
    else:
        data["test MyGroups()"] = "FAILED"

    # 17 test GetQuestions()
    if (test_GetQuestions.test() == 1):
        data["test GetQuestions()"] = "PASS"
    else:
        data["test GetQuestions()"] = "FAILED"

    # 18 test run_Code()
    if (test_run_code.test() == 1):
        data["test run_code()"] = "PASS"
    else:
        data["test run_code()"] = "FAILED"

    # 19 test MyBlogs()
    if (test_MyBlogs.test() == 1):
        data["test MyBlogs()"] = "PASS"
    else:
        data["test MyBlogs()"] = "FAILED"

    return data

    