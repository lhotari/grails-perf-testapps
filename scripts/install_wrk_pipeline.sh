#!/bin/sh
cd /tmp
git clone -b pipeline https://github.com/wg/wrk
cd wrk
make
sudo cp wrk /usr/local/bin/wrk-pipeline
ls -ltra /usr/local/bin/wrk-pipeline


