#Just
# "K.R. Wuite <gitkelvin.id>"
# ADB module logic: https://github.com/kelvin-id/asd-submodule

APP_VERSION:="0.0.29"

POETRY_RUN:="poetry run"
JUST:="just --unstable"
ADB:="adb -s localhost:5555"
APP_NAME:="com.heattheatr.kivy_service_test"
APK_NAME:="kivy_service_test-" + APP_VERSION + "-x86_64-debug.apk"

# Install Python environment
install:
    poetry install

# Connect with localhost:5555
adb-connect:
    adb connect localhost:5555

# List connected devices
adb-devices:
    adb devices

# Imstall Android APK
adb-install:
    {{ADB}} install ./bin/{{APK_NAME}}

# Remove the Android APP
adb-remove:
    {{ADB}} uninstall {{APP_NAME}}

# Force stop Android application
adb-stop:
    {{ADB}} shell am force-stop {{APP_NAME}}

# Start Android application using ADB
adb-start:
    {{ADB}} shell am start -n {{APP_NAME}}/org.kivy.android.PythonActivity

# Show Python logs with logcat
adb-log-python:
    {{ADB}} logcat | grep -e 'python  :'

# Show APP logs with logcat
adb-log-app:
    {{ADB}} logcat | grep -e 'ServiceTest'

# Show the Android APK logs
adb-log-apk:
    {{ADB}} logcat | grep {{APP_NAME}}

# ADB list all packagges
adb-list:
    {{ADB}} shell pm list packages

# Kivy

# Builds APK and saves in ./bin
build:
    {{POETRY_RUN}} buildozer -v android debug

# Pushes APK directly to the docker-android container
deploy:
    {{POETRY_RUN}} buildozer -v android deploy

# Builds and pushes APK to Android
build-deploy:
    {{POETRY_RUN}} buildozer -v android debug deploy

# stop > build > deploy > start > tail logs
run: adb-stop build-deploy adb-start adb-log-app 

# Cleans build artifacts
clean:
    rm -rf .buildozer/android/app
    rm -rf .buildozer/android/platform/build-x86_64/dists
    rm -rf ./bin
