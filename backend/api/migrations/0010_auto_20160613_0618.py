# -*- coding: utf-8 -*-
# Generated by Django 1.9.6 on 2016-06-13 06:18
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0009_remove_candidate_spoc'),
    ]

    operations = [
        migrations.AlterField(
            model_name='jd',
            name='end_date',
            field=models.DateField(),
        ),
        migrations.AlterField(
            model_name='jd',
            name='start_date',
            field=models.DateField(),
        ),
    ]
