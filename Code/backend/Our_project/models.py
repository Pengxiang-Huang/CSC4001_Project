from django.db import models

# Create your models here.
class User(models.Model):
    username = models.CharField(verbose_name='NAME', max_length=30, unique=True)
    password = models.CharField(verbose_name='PASSWD', max_length=32)
    email = models.CharField(verbose_name='EMAIL', max_length=50, default='')
    photo = models.CharField(verbose_name='PHOTO', max_length=50, default='', blank = True)
    create_time = models.DateTimeField('Established Time', auto_now_add=True)
    update_time = models.DateTimeField('Updated Time', auto_now=True)
    def __str__(self):
        return self.username

class Blog_Questions(models.Model):
    title = models.CharField(verbose_name='TITLE', max_length=200)
    author_id = models.IntegerField(verbose_name = 'AUTHOR_ID')
    group_type = models.CharField(verbose_name = 'GROUP_ID', max_length=45)
    sub_group_type = models.IntegerField(verbose_name='SUB_GROUP_ID', blank = True)
    content = models.CharField(verbose_name='CONTENT', max_length=20000)
    code = models.CharField(verbose_name='CODE', max_length=1400)
    lang = models.CharField(verbose_name="Language", max_length = 45)
    content_format = models.CharField(verbose_name = 'FORMAT', max_length = 45)
    like = models.IntegerField(verbose_name='LIKE')
    follow = models.IntegerField(verbose_name='FOLLOW')
    hot = models.IntegerField(verbose_name='HOT')
    create_time = models.DateTimeField('Established Time', auto_now_add=True)
    update_time = models.DateTimeField('Updated Time', auto_now=True)
    views = models.IntegerField(verbose_name='VIEWS')
    def __str__(self):
        return self.title

class Blog_Answers(models.Model):
    question_id = models.IntegerField(verbose_name='Corresponding Question')
    father_answer_id = models.IntegerField(verbose_name = 'Corresponding Answer')
    content = models.CharField(verbose_name='CONTENT', max_length = 20000)
    code = models.CharField(verbose_name='CODE', max_length=1400)
    lang = models.CharField(verbose_name="Language", max_length = 45)
    content_format = models.CharField(verbose_name = 'FORMAT', max_length = 45)
    like = models.IntegerField(verbose_name='LIKE')
    author_id = models.IntegerField(verbose_name='AUTHOR')
    def __str__(self):
        return "answer to Question (" + str(self.question_id) + ")"


class picture(models.Model):
    url = models.CharField(verbose_name='URL', max_length = 100, unique = True)
    answer = models.IntegerField(verbose_name=' Corresponding ANSWER', blank = True)
    question = models.IntegerField(verbose_name='Corresponding QUESTION', blank = True)
    group_name = models.CharField(verbose_name='GROUP_NAME', max_length = 45, blank = True)
    create_time = models.DateTimeField('Established Time', auto_now_add=True)
    def __str__(self):
        if (self.answer):
            return "picture of answer - " + str(self.answer)
        elif (self.question):
            return "picture of question - " + str(self.question)
        return "picture of group - " + str(self.group_name)

# Relation between user and question. 
class user_like_question(models.Model):
    question_id = models.IntegerField(verbose_name = "Corresponding Question_ID")
    def __str__(self):
        return self.question_id

class user_follow_question(models.Model):
    question_id = models.IntegerField(verbose_name = "Corresponding Question_ID")
    def __str__(self):
        return self.question_id

class user_follow_group(models.Model):
    group_name = models.CharField(verbose_name='Corresponding Group', max_length = 45, unique = True)
    def __str__(self):
        return self.group_name

class user_like_answer(models.Model):
    answer_id = models.IntegerField(verbose_name = "Corresponding ANSWER")
    def __str__(self):
        return self.answer_id

class Group(models.Model):
    group_name = models.CharField(verbose_name='GROUP_NAME', max_length = 45, unique = True)
    description = models.CharField(verbose_name = 'DESCRIPTION', max_length = 1000)
    amount_of_follows = models.IntegerField(verbose_name = 'AMOUNT_OF_FOLLOWS')
    create_time = models.DateTimeField('Established Time', auto_now_add=True)
    update_time = models.DateTimeField('Updated Time', auto_now=True)
    def __str__(self):
        return self.group_name


class sub_group(models.Model):
    group_name = models.CharField(verbose_name='GROUP_NAME', max_length = 45)
    sub_group_name = models.CharField(verbose_name='SUB_GROUP_NAME', max_length = 45)
    def __str__(self):
        return self.sub_group_name

class file(models.Model):
    url = models.CharField(verbose_name='URL', max_length = 45, unique = True)
    corresponding_question = models.IntegerField(verbose_name='Corresponding_QUESTION', blank = True)
    corresponding_answer = models.IntegerField(verbose_name='Corresponding_ANSWER', blank = True)
    create_time = models.DateTimeField('Established Time', auto_now_add=True, blank = True)
    def __str__(self):
        if (self.corresponding_answer):
            return "file of answer (" + str(self.corresponding_answer) + ")"
        return "file of question (" + str(self.corresponding_question) + ")"