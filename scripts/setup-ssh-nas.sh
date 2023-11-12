#!/bin/bash

SERVER="192.168.1.55"
USERNAME="bknightinfo"

echo "Enable RSync with Synology without RSA SSH-key"

ssh-keygen -t rsa
chmod 700 ~/.ssh && chmod 600 ~/.ssh/*
ssh-copy-id $USERNAME@$SERVER