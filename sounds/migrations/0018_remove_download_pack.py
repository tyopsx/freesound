# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2018-01-23 12:52
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sounds', '0017_auto_20180117_1553'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='download',
            name='pack',
        ),
        migrations.RunSQL('DELETE FROM sounds_download WHERE sound_id IS NULL')
    ]
