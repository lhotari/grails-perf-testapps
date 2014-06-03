#!/bin/bash
YJP_HOME="$1"
if [ ! -d "$YJP_HOME/lib" ]; then
	echo usage: $0 yjp_home_directory
	exit 1
fi
YJP_AGENT_LIB=`ls "$YJP_HOME"/bin/*/*yjpagent*`
if [ -e grails-app/conf/BuildConfig.groovy ]; then
	cat >> grails-app/conf/BuildConfig.groovy <<EOF
def yjpConfig = [jvmArgs: [
        "-agentpath:\"$YJP_AGENT_LIB\"=delay=30000,disablealloc,disablej2ee,noj2ee,builtinprobes=none,sampling,monitors,onexit=snapshot,telemetryperiod=250"
    ]]
if (System.getProperty("grails.yjp")) {
    grails.project.fork.war += yjpConfig
    println "Using YJP for run-war"
}
EOF
else
	echo "Run this script in a Grails application directory"
fi
