from django.db import models

# Create your models here.
class User(models.Model):
    username = models.CharField(verbose_name='NAME', max_length=30, unique=True)
    password = models.CharField(verbose_name='PASSWD', max_length=32)
    email = models.CharField(verbose_name='EMAIL', max_length=50, default='')
    create_time = models.DateTimeField('Established Time', auto_now_add=True)
    update_time = models.DateTimeField('Updated Time', auto_now=True)
    def __str__(self):
        return 'User' + self.username

class Blog_Questions(models.Model):
    title = models.CharField(verbose_name='TITLE', max_length=200)
    author_id = models.IntegerField(verbose_name = 'AUTHOR_ID')
    group_type = models.CharField(verbose_name = 'GROUP_TYPE', max_length=45)
    sub_group_type = models.IntegerField(verbose_name='SUB_GROUP_TYPE')
    content = models.CharField(verbose_name='CONTENT', max_length=20000)
    content_format = models.CharField(verbose_name = 'FORMAT', max_length = 45)
    like = models.IntegerField(verbose_name='LIKE')
    follow = models.IntegerField(verbose_name='FOLLOW')
    hot = models.IntegerField(verbose_name='HOT')
    create_time = models.DateTimeField('Established Time', auto_now_add=True)
    update_time = models.DateTimeField('Updated Time', auto_now=True)

class Blog_Answers(models.Model):
    question_id = models.IntegerField(verbose_name='QUESTION_ID')
    father_answer_id = models.IntegerField(verbose_name = 'FATHER_ANSWER')
    content = models.CharField(verbose_name='CONTENT', max_length = 20000)
    content_format = models.CharField(verbose_name = 'FORMAT', max_length = 45)
    like = models.IntegerField(verbose_name='LIKE')
    author_id = models.IntegerField(verbose_name='AUTHOR')


class picture(models.Model):
    url = models.CharField(verbose_name='URL', max_length = 100, unique = True)
    answer = models.IntegerField(verbose_name='ANSWER')
    question = models.IntegerField(verbose_name='QUESTION')
    create_time = models.DateTimeField('Established Time', auto_now_add=True)