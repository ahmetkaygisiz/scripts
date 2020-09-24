import os
import java.util.ArrayList as ArrayList

def getThreadStartTime(currentRequest):
 
	if ( currentRequest is not None and "Started" in currentRequest ):
		 
		tmp1 = currentRequest.split('\n')
	        tmp2 = tmp1[0].split(':')
        	tmp3 = tmp2[3].split(' ')

		return int(tmp3[1])
	return 0

def getThreadList():
    serverRuntime()
    cd('ThreadPoolRuntime/ThreadPoolRuntime')
    tmpArr = ArrayList()

    for tp in cmo.getExecuteThreads():
	str = tp.getCurrentRequest()
	reqTime = getThreadStartTime(str)
	
	# Burası parametrik olacak. x MS sonrasında kalan thread'leri bul.	
   	if ( reqTime > 2000 ):
		#print tp.getCurrentRequest()
		tmpArr.add(tp.getName()) 
	
    return tmpArr

###
#	Main
###	
	
user = 'weblogic'
password ='welcome1'
url = 't3://localhost:7001'
script = './getThreadDump.sh'

connect(user, password, url);

x = getThreadList()

os.system('bash '+ script + ' '+ str(x))
