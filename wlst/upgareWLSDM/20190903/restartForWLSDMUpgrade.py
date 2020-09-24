#Author :   Volthread | Ahmet Kaygisiz | ahmet.kaygisiz@volthread.com
 
import sys
import java.util.ArrayList as ArrayList
from java.lang import System
import os

####
##      ==> ManagedServer Functions
####

def getStatus(ServerName):
    cd('domainRuntime:/ServerLifeCycleRuntimes/'+ServerName)
    serverState = cmo.getState()
    return serverState

def stop(ServerName):
    cd('domainRuntime:/ServerLifeCycleRuntimes/'+ServerName)
    cmo.forceShutdown()
    state = getStatus(ServerName)

    while (state!='SHUTDOWN'):
        state=getStatus(ServerName)
        java.lang.Thread.sleep(5000)

def start(ServerName):
    cd('domainRuntime:/ServerLifeCycleRuntimes/'+ServerName)
    cmo.start()
    state=getStatus(ServerName)
    while (state!='RUNNING'):
        state=getStatus(ServerName)
        java.lang.Thread.sleep(5000)

def restartServer(ServerName):
    state=getStatus(ServerName)
    if state!='SHUTDOWN':
        stop(ServerName)
        start(ServerName)

def getServerList():
    serverList = ArrayList()
    try:
        for s in cmo.getServers():
            serverList.add(s.getName())
        return serverList
    except Exception, err:
        print err

def hasWLSDMParams(ServerName):
    cd('serverConfig:/Servers/'+ServerName+'/ServerStart/'+ServerName)
    args = cmo.getArguments()
    
    if args:
       if "wlsdm" in args:
            return true
       else:
            return false
    else:
        return false
####
##  AdminServer Restart Functions
####

def hasAdminMachine():
    cd('serverConfig:/')
    domainName = cmo.getName()
    adminServerName = cmo.getAdminServerName()
    print adminServerName + " " + domainName

    cd('serverConfig:/Targets/'+adminServerName)
    
    if not cmo.getMachine():
        print "Machine Null"
	return 
    else:
        machineName=cmo.getMachine().getName()
        cd('serverConfig:/Targets/'+adminServerName+'/Machine/'+machineName+'/NodeManager/'+machineName)
        nmListenAddress = cmo.getListenAddress()
        nmListePort = cmo.getListenPort()
        
        return machineName

def stopAdminServerWnm(serverName):
    nmKill(serverName)
    
    while (nmServerStatus(serverName)!='SHUTDOWN'):
        java.lang.Thread.sleep(5000)

def startAdminServerWnm(serverName):
    nmStart(serverName)

    while (nmServerStatus(serverName) != 'RUNNING'):
        java.lang.Thread.sleep(5000)

def restartAdminServer(hostname,wlUser,wlPass,sshScript,sshUser,sshPass,rScript):

    cd('serverConfig:/')
    domainName = cmo.getName()
    adminServerName = cmo.getAdminServerName()
    machineName = hasAdminMachine()

    if  machineName:
        cd('serverConfig:/Targets/'+adminServerName+'/Machine/'+machineName+'/NodeManager/'+machineName)        
        nmListenAddress = cmo.getListenAddress()
        nmListenPort = cmo.getListenPort()
       
        nmConnect(wlUser,wlPass,nmListenAddress,nmListenPort,domainName)
        stopAdminServerWnm(adminServerName)
        startAdminServerWnm(adminServerName)

    else :
        try :
            stop(adminServerName)
        except Exception, err:
            print "Shutdown completed."    
	
        os.system('bash '+sshScript+' '+hostname+' '+sshUser+' '+sshPass+' '+rScript)

####
##    ==> Read CSV File
####

def readCsv(list, fileName):
    
    try :
	f = open(fileName)
        for line in f.readlines():
            if line.strip().startswith('#'):
                continue
            else:
                items = line.split(',')
                arr = ArrayList()

		for it in items:
			arr.add(it);
                arr.add(domain)
        return arr
    
    except Exception, err:
        print err
    
    finally:
	f.close()

####
##    ==>  Main 
####

fileName = sys.argv[1]
arr = readCsv(fileName)

for line in arr:
    hostname= line.get('hostname')
    wlUrl = line.get('hostname') + ':' +line.get('port')
    wlUser = line.get('wluser')
    wlPass = line.get('wlpass')

    sshUser=line.get('sshUser')
    sshPass=line.get('sshPass')
    rScript = line.get('scriptPath')
    sshScript = "./remoteSSH.sh" 

    try :
       if (wlUser != "#"):
		connect(wlUser,wlPass,wlUrl)

	        for s in getServerList():
	           if hasWLSDMParams(s):
        	        restartServer(s)
       		restartAdminServer(hostname,wlUser,wlPass,sshScript,sshUser,sshPass,rScript)
    except Exception, err:
        print err 

#restartAdminServer("10.40.65.83","weblogic","welcome1","./remoteSSH.sh","cissys","welcome1","/appdata/scripts/admin_start.sh")
