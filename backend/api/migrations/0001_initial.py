# -*- coding: utf-8 -*-
# Generated by Django 1.9.6 on 2016-06-07 06:13
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Agent',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'agent',
            },
        ),
        migrations.CreateModel(
            name='Candidate',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('mobile_number', models.CharField(max_length=255, null=True)),
                ('email_id', models.EmailField(max_length=255, null=True)),
                ('location', models.CharField(max_length=255, null=True)),
                ('walk_in_date', models.DateTimeField()),
                ('agent', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='to_agent', to='api.Agent')),
            ],
            options={
                'db_table': 'candidate',
            },
        ),
        migrations.CreateModel(
            name='Company',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
            ],
            options={
                'db_table': 'company',
            },
        ),
        migrations.CreateModel(
            name='JD',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('job_title', models.CharField(max_length=255)),
                ('job_description', models.CharField(max_length=255, null=True)),
                ('candidates_req', models.IntegerField(default=1, max_length=255)),
                ('min_experience', models.IntegerField(default=0, max_length=255)),
                ('max_experience', models.IntegerField(default=0, max_length=255)),
                ('min_salary', models.IntegerField(max_length=255, null=True)),
                ('max_salary', models.IntegerField(max_length=255, null=True)),
                ('start_date', models.DateTimeField()),
                ('end_date', models.DateTimeField()),
                ('status', models.CharField(choices=[(b'Closed', b'Closed'), (b'Open', b'Open')], default=b'Open', max_length=20)),
            ],
            options={
                'db_table': 'jd_table',
            },
        ),
        migrations.CreateModel(
            name='Location',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
            ],
            options={
                'db_table': 'location',
            },
        ),
        migrations.CreateModel(
            name='SPOC',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('company', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.Company')),
                ('location', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.Location')),
                ('name', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'SPOC_table',
            },
        ),
        migrations.CreateModel(
            name='Status',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('modified_at', models.DateTimeField(auto_now=True)),
                ('remarks', models.CharField(max_length=255)),
                ('agent', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.Agent')),
                ('candidate', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='statusModel', to='api.Candidate')),
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
            model_name='jd',
            name='SPOC',
            field=models.ManyToManyField(to='api.SPOC'),
        ),
        migrations.AddField(
            model_name='jd',
            name='agent',
            field=models.ManyToManyField(to='api.Agent'),
        ),
        migrations.AddField(
            model_name='jd',
            name='company',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.Company'),
        ),
        migrations.AddField(
            model_name='jd',
            name='location',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.Location'),
        ),
        migrations.AddField(
            model_name='candidate',
            name='jd',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.JD'),
        ),
        migrations.AddField(
            model_name='candidate',
            name='spoc',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='to_spoc', to='api.SPOC'),
        ),
        migrations.AddField(
            model_name='candidate',
            name='status',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.StatusType'),
        ),
    ]