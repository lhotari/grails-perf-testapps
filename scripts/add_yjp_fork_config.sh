#!/bin/bash
if [ -e grails-app/conf/BuildConfig.groovy ]; then
cat >> grails-app/conf/BuildConfig.groovy <<EOF
def yjpConfig = [jvmArgs: [
        "-agentpath:/opt/yjp/bin/linux-x86-64/libyjpagent.so=delay=30000,disablealloc,disablej2ee,noj2ee,builtinprobes=none,sampling,monitors,onexit=snapshot,telemetryperiod=250"
    ]]
if (System.getProperty("grails.yjp")) {
    grails.project.fork.war += yjpConfig
    println "Using YJP for run-war"
}
EOF
fi
