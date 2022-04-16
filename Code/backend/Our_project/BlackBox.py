from .BlackBox_Testing import test_code
from .BlackBox_Testing import test_register
from .BlackBox_Testing import test_login

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
    
    # 2. test view.register
    if (test_register.test() == 1):
        data["test-register()"] = "PASS"
    else:
        data["test-register()"] = "FAILED"

    # 3. test views.login()
    if (test_login.test() == 1):
        data["test-login()"] = "PASS"
    else:
        data["test-login()"] = "FAILED"
    return data

    