#!/bin/sh
sudo tee /etc/security/limits.d/99-openfiles-limit.conf <<EOF
* soft nofile 64000
* hard nofile 64000
EOF
# uncomment "session    required   pam_limits.so" line in /etc/pam.d/su file
sudo sed -i '/# session\s\+required\s\+pam_limits.so/ s/# *//' /etc/pam.d/su

