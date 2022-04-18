from .Component_Testing import test_register
from .Component_Testing import test_login_then_logout
from .Component_Testing import test_mainpage
from .Component_Testing import test_Post
from .Component_Testing import test_Blog
from .Component_Testing import test_like_follow



def test():
    data = {}
    
    # 1. test a full journey of register
    if (test_register.test() == 1):
        data["test_register()"] = "PASS"
    else:
        data["test_register()"] = "FAILED"

    # 2. test f ful journey of login then logout
    if (test_login_then_logout.test() == 1):
        data["test-login_then_logout()"] = "PASS"
    else:
        data["test-login_then_logout()"] = "FAILED"

    # 3. test a full APi of Mainpage
    if (test_mainpage.test() == 1):
        data["test_mainpage()"] = "PASS"
    else:
        data["test_mainpage()"] = "FAILED"

    # 4. test a full APi of Post Question
    if (test_Post.test() == 1):
        data["test_Post()"] = "PASS"
    else:
        data["test_Post()"] = "FAILED"

    # 5. test a full Api of 帖子页面
    if (test_Blog.test() == 1):
        data["test_Blog()"] = "PASS"
    else:
        data["test_Blog()"] = "FAILED"

    # 6. test a full API of like, follow
    if (test_like_follow.test() == 1):
        data["test_like_follow()"] = "PASS"
    else:
        data["test_like_follow()"] = "FAILED"

    return data

    