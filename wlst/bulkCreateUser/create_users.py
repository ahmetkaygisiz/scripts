import sys
import java.util.ArrayList as ArrayList
from java.io import FileInputStream

####
##  ==>Add Users
####

def createUsers(domainName,realmName):
        propInputStream = FileInputStream("domain_and_users.properties")
        
        configProps = Properties()
        configProps.load(propInputStream)
        
        totalUsers_to_Create=configProps.get("total.username")

	serverConfig()
	authenticatorPath= '/SecurityConfiguration/' + domainName + '/Realms/' + realmName + '/AuthenticationProviders/DefaultAuthenticator'
	print authenticatorPath
	cd(authenticatorPath)
	print ' '
	print ' becareful users are creating, please check'

	print 'Creating Users . . .'
	x=1
	while (x <= int(totalUsers_to_Create)):
	    userName = configProps.get("create.user.name."+ str(x))
	    userPassword = configProps.get("create.user.password."+ str(x))
	    userDescription = configProps.get("create.user.description."+ str(x))
	    print 'Creating User: ', userName ,' started'
	    try:
	        cmo.createUser(userName , userPassword , userDescription)
	        print '-----------User Created With Name : ' , userName
	    except:
	        print '************* Check  Error: username=  ' , userName ,' getting Error while creating **** '
	    x = x + 1
	print ' '
	print 'completed '
	print 'adding group . . .'
	x=1
	while (x <= int(totalUsers_to_Create)):
	    userName = configProps.get("create.user.name."+ str(x))
	    cmo.addMemberToGroup('cisusers',userName)
	    x = x + 1
	print '    OK     '
	print 'Total ', totalUsers_to_Create , ' users created and added to cisusers group'

####
##   ==> Read Host Info
####

def readCsv(fileName):
    f = open(fileName)
    arr = ArrayList()

    try :
        for line in f.readlines():
            if line.strip().startswith('#'):
                continue
            else:
                items = line.split(',')
                domain = {'domainName':items[0],'adminUrl':items[1],'wluser':items[2],'wlpass':items[3],'securityRealms':items[4].strip('\n')}
                arr.add(domain)
        return arr
    except Exception, err:
        print err

####
##    ==>  Main 
####

fileName = sys.argv[1]
arr = readCsv(fileName)

for line in arr:
    domainName = line.get('domainName')
    wlUrl = line.get('adminUrl')
    wlUser = line.get('wluser')
    wlPass = line.get('wlpass')
    secRealms = line.get('securityRealms')
    
    try:
        connect(wlUser,wlPass,wlUrl)
        createUsers(domainName,secRealms)
    except Exception, err:
        print err 

disconnect()
exit()
