import yaml

def readCsv(fileName):

    try :
        f = open(fileName)
	listArray = ArrayList()

        for line in f.readlines():
            if line.strip().startswith('#'):
                continue
            else:
                items = line.split(',')
                arr = ArrayList()

                for it in items:
                        arr.add(it)
                
		listArray.add(arr)
	return listArray
    except Exception, err:
        print err

###
#	Main
###

domainArr = readCsv(sys.argv[1])
serverArr = readCsv(sys.argv[2])

for arr in domainArr:
	hostName=arr[0]
	port=arr[1]
	wlUserName=arr[2]
	wlPass=arr[3]
		
	

