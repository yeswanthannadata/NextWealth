# -*- coding: utf-8 -*-
# Generated by Django 1.9.6 on 2016-06-13 06:10
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_auto_20160609_1843'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='candidate',
            name='spoc',
        ),
    ]
