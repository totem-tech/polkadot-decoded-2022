#!/usr/bin/env bash

screen -d -m rococo-local-auth1 sh ./start-auth1.sh;
screen -d -m rococo-local-auth2 sh ./start-auth2.sh;
screen -d -m rococo-local-ui1 sh ./start-ui1.sh;