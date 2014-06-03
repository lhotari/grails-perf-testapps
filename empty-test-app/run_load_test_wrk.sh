#!/bin/bash
function run_test() {
   for ((i=1;i<=1000;i+=1)); do
      echo Round $i
      wrk -t 10 -c 10 --latency http://localhost:8080/empty-test-app/empty/index
      if [ $? -ne 0 ]; then
         exit 1
      fi
      let modulus=$i%3
      if [ $modulus -eq 0 ]; then
         echo Wait 10 secs
         sleep 10
      fi
   done
}
run_test
