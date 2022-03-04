from django.db import models

# Create your models here.

# describe the Database
class students(models.Model):
    user_id = models.CharField(max_length=10)
    passcode = models.CharField(max_length=20)

    

