"""SW_Project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from Our_project import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index),
    path('register/',views.register),
    path('login/', views.login),
    path('first/', views.after_login),
    path('logout/', views.logout),
    path('sendEmail/', views.sendEmail),
    path('updateInformation/', views.update),
    path('search', views.searchQuestion),
    path('SetQuestion', views.setQuestion),
    path('mainpage/', views.main_page),
    path('myFollow/', views.my_follow),
    path('myGroup/', views.my_group),
    path('unAnswered/', views.unAnswered),
    path('api/like/', views.like),
    path('api/follow/', views.follow),
    path('api/uploadProfile/', views.uploadProfile),
    path('api/getProfile/', views.getProfile),
    path('api/getGroup/', views.getGroup),    # return the basic information of the Group, and the content of subgroups
    path('api/followGroup/', views.followGroup),  # allow a user to follow the Group
    path('api/Groups/', views.groups),   # return all the groups as well as their basic info 
    path('api/MyGroups/', views.MyGroups),
    path('api/GetQuestions', views.GetQuestions),
    path('api/GetAnswers', views.GetAnswers),
    path('api/RunCode', views.run_code),
    path('api/MyBlogs', views.MyBlogs),
    path('api/Reply', views.Reply),
    path('api/AddViews', views.AddViews),
    path('api/testing', views.testing),
    path('api/verify', views.verify),
    path('api/getfile', views.get_file),
]
