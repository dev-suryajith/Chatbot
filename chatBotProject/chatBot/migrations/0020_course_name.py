# Generated by Django 4.2.18 on 2025-02-24 04:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chatBot', '0019_applications_alloted_course_course_seats'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='name',
            field=models.CharField(blank=True, max_length=10, null=True),
        ),
    ]
