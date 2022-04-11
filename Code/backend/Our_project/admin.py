from django.contrib import admin

from .models import User
from .models import Blog_Questions
from .models import picture
from .models import Blog_Answers
from .models import Group
from .models import sub_group
from .models import file
from .models import user_like_question
from .models import user_follow_question
from .models import user_follow_group
from .models import user_like_answer

class UserAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'create_time', 'update_time')
    search_fields = ('username', 'email')

class SubGroupAdmin(admin.ModelAdmin):
    list_display = ('sub_group_name', 'group_name')
    search_fields = ('sub_group_name', 'group_name')

class PicturesAdmin(admin.ModelAdmin):
    list_display = ('url', 'question', 'answer', 'create_time')
    search_fields = ('answer', 'url')

class GroupAdmin(admin.ModelAdmin):
    list_display = ('group_name', 'amount_of_follows', 'create_time', 'update_time')
    search_fields = ['group_name']

class FileAdmin(admin.ModelAdmin):
    list_display = ('url', 'corresponding_question', 'corresponding_answer','create_time')
    search_fields = ['corresponding_question', 'url']

class QuestionAmdim(admin.ModelAdmin):
    list_display = ('title','author_id', 'group_type', 'sub_group_type', 'like', 'follow', 'views', 'hot', 'create_time', 'update_time')
    search_fields = ['title', 'author_id', 'group_type']

class AnswerAdmin(admin.ModelAdmin):
    list_display = ['question_id','father_answer_id', 'author_id', 'like']
    search_fields = ['question_id', 'father_answer_id', 'author_id']

class user_like_question_Admin(admin.ModelAdmin):
    list_display = ['question_id']
    search_fields = ['question_id']

class user_follow_question_Admin(admin.ModelAdmin):
    list_display = ['question_id']
    search_fields = ['question_id']

class user_follow_group_Admin(admin.ModelAdmin):
    list_display = ['group_name']
    search_fields = ['group_name']

class user_like_answer_Admin(admin.ModelAdmin):
    list_display = ['answer_id']
    search_fields = ['answer_id']

admin.site.register(User,UserAdmin)
admin.site.register(Blog_Questions, QuestionAmdim)
admin.site.register(picture, PicturesAdmin)
admin.site.register(Blog_Answers, AnswerAdmin)
admin.site.register(Group, GroupAdmin)
admin.site.register(sub_group, SubGroupAdmin)
admin.site.register(file, FileAdmin)

admin.site.register(user_like_question, user_like_question_Admin)
admin.site.register(user_follow_question, user_follow_question_Admin)
admin.site.register(user_follow_group, user_follow_group_Admin)
admin.site.register(user_like_answer, user_like_answer_Admin)

