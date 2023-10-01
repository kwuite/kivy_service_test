# [Read the article](https://habr.com/ru/post/694906/)

## Requirements

- [poetry](https://python-poetry.org/docs/)
- [just](https://just.systems/man/en/chapter_4.html)
- python 3.10 (tested)
- Use [docker-android](https://github.com/budtmo/docker-android) and set `android.archs = x86_64` in [buildozer.spec](buildozer.spec) 

Buildozer (Ubuntu/Debian):
```
sudo apt install -y git zip unzip openjdk-8-jdk python3-pip autoconf libtool pkg-config zlib1g-dev libncurses5-dev libncursesw5-dev libtinfo5 cmake libffi-dev libssl-dev
```

## Setup
Written for Ubuntu/Debian

1. `just install`
2. `just run`

In case your device is not running on localhost:5555, change line 9 in [Justfile](./Justfile)
```
ADB:="adb -s localhost:5555"
```
and remove `-s localhost:5555` or change the tcp argument.

## Commands

To show all commands: `just --list`
