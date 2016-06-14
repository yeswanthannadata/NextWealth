# -*- coding: utf-8 -*-
# Generated by Django 1.9.6 on 2016-06-06 15:49
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Status',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('modified_at', models.DateTimeField(auto_now=True)),
                ('remarks', models.CharField(max_length=255)),
                ('agent', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.Agent')),
            ],
            options={
                'db_table': 'status',
            },
        ),
        migrations.CreateModel(
            name='StatusType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status_field', models.CharField(max_length=255)),
            ],
            options={
                'db_table': 'statu_type',
            },
        ),
        migrations.AddField(
            model_name='candidate',
            name='email_id',
            field=models.EmailField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='candidate',
            name='location',
            field=models.CharField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='candidate',
            name='mobile_number',
            field=models.CharField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='jd',
            name='candidates_req',
            field=models.IntegerField(default=1, max_length=255),
        ),
        migrations.AddField(
            model_name='jd',
            name='company',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.Company'),
        ),
        migrations.AddField(
            model_name='jd',
            name='job_description',
            field=models.CharField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='jd',
            name='max_experience',
            field=models.IntegerField(default=0, max_length=255),
        ),
        migrations.AddField(
            model_name='jd',
            name='max_salary',
            field=models.IntegerField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='jd',
            name='min_experience',
            field=models.IntegerField(default=0, max_length=255),
        ),
        migrations.AddField(
            model_name='jd',
            name='min_salary',
            field=models.IntegerField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='jd',
            name='status',
            field=models.CharField(choices=[(b'Closed', b'Closed'), (b'Open', b'Open')], default=b'Open', max_length=20),
        ),
        migrations.AddField(
            model_name='status',
            name='candidate',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='statusModel', to='api.Candidate'),
        ),
        migrations.AddField(
            model_name='status',
            name='status',
            field=models.ManyToManyField(to='api.StatusType'),
        ),
    ]