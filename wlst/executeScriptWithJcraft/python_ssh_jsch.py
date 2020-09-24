from com.jcraft.jsch import JSch

from org.python.core.util import FileUtil
from java.lang import System

jsch=JSch()


host="10.3.407.170"; #intentionally  wrong here
user="myuser"
session=jsch.getSession(user, host, 22);
session.setPassword("coolpassword");

session.setConfig("StrictHostKeyChecking", "no");

session.connect();

command="ls"

channel=session.openChannel("exec");
channel.setCommand(command);

# X Forwarding
# channel.setXForwarding(true);

#channel.setInputStream(System.in);
channel.setInputStream(None);

#channel.setOutputStream(System.out);

#FileOutputStream fos=new FileOutputStream("/tmp/stderr");
#((ChannelExec)channel).setErrStream(fos);
channel.setErrStream(System.err);
instream=channel.getInputStream();

channel.connect();


fu = FileUtil.wrap(instream)

for line in fu.readlines():
print line

if channel.isClosed():
    print "exit-status: "+channel.getExitStatus()

try:
    Thread.sleep(1000)
except:
    print e

channel.disconnect();
session.disconnect();﻿
