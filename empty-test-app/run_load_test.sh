#!/bin/bash
function run_test() {
   for ((i=1;i<=1000;i+=1)); do
      echo Round $i
      ab -c 10 -n 1000 http://127.0.0.1:8080/empty-test-app/empty/index
      if [ $? -ne 0 ]; then
         exit 1
      fi
      let modulus=$i%20
      if [ $modulus -eq 0 ]; then
         echo Wait 10 secs
         sleep 10
      fi
   done
}
OUTPUT=/tmp/run_test$$
run_test > $OUTPUT 2>&1 &
RUN_TEST_PID=$!
watch -c "grep 'Requests per second:' $OUTPUT |sort -n|tail -25"
kill $RUN_TEST_PID
echo "output is in $OUTPUT"

