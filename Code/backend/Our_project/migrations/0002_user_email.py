# Generated by Django 3.2.3 on 2022-03-06 13:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Our_project', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='email',
            field=models.CharField(default='', max_length=50, verbose_name='EMAIL'),
        ),
    ]
