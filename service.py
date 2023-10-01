#!/usr/bin/python3
#-*- coding: utf-8 -*-

import os

from time import sleep
from kivy.utils import platform
from kivy.logger import Logger

from jnius import cast
from jnius import autoclass


# Подключение классов Android
if platform == 'android':
    PythonService = autoclass('org.kivy.android.PythonService')
    # Автоперезапуск упавшего сревиса
    PythonService.mService.setAutoRestartService(True)

    CurrentActivityService = cast("android.app.Service", PythonService.mService)
    ContextService = cast('android.content.Context', CurrentActivityService.getApplicationContext())
    ContextWrapperService = cast('android.content.ContextWrapper', CurrentActivityService.getApplicationContext())
    Manager = CurrentActivityService.getPackageManager()

    Intent = autoclass('android.content.Intent')

    def application_start():
        Logger.info(f'ServiceTest: Starting application')
        pm = CurrentActivityService.getPackageManager()
        ix = pm.getLaunchIntentForPackage(CurrentActivityService.getPackageName())
        ix.setAction(Intent.ACTION_VIEW)
        ix.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        CurrentActivityService.startActivity(ix)
        Logger.info(f'ServiceTest: Application started')

    while True:
        Logger.info(f'ServiceTest: python service running... | {CurrentActivityService.getPackageName()} | {os.getpid()}')
        sleep(6)
else:
    def application_start():
        pass

    while True:
        Logger.info(f'ServiceTest: python service running... | {os.getpid()}')
        sleep(6)
