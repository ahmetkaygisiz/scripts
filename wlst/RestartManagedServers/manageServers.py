import sys
import os
from java.lang import System

def getStatus(ServerName):
    cd('domainRuntime:/ServerLifeCycleRuntimes/'+ServerName);
    serverState = cmo.getState();
    return serverState

def stop(ServerName):
    cd('domainRuntime:/ServerLifeCycleRuntimes/'+ServerName);
    cmo.forceShutdown();
    state = getStatus(ServerName);
    
    while (state!='SHUTDOWN'):
        state=getStatus(ServerName);
        java.lang.Thread.sleep(5000);
    
def start(ServerName):
    cd('domainRuntime:/ServerLifeCycleRuntimes/'+ServerName);
    cmo.start();
    state=getStatus(ServerName);
    while (state!='RUNNING'):
        state=getStatus(ServerName);
        java.lang.Thread.sleep(5000);


def restartServers():
    if command =='restart':
	state=getStatus(ServerName);
        if state!='SHUTDOWN':
            stop(ServerName);
            state=getStatus(ServerName);
            start(ServerName);

    else:
	print "Wrong input.";
	print "Usage  --> wlst.sh username password adminUrl ServerName restart";
   	exit();

## Main ##
# ================================================================
#           Main Code Execution
# ================================================================

if __name__== "main":

    username = sys.argv[1];
    password = sys.argv[2];
    adminUrl = sys.argv[3];
    ServerName = sys.argv[4];
    command = sys.argv[5];

    connect(username, password, adminUrl);
    restartServers();
    disconnect();
    exit();
