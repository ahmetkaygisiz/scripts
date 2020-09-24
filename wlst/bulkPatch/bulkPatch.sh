#!/bin/bash

## Dosyaları multiple scp ile sunucuya at.
## wlst -> getServerList, sunucuları yeniden başlat.
## NM'e bağlan,NM'ı kapat.

# https://gist.github.com/huskercane/5398dda24b3938226348
#-----------
#
# Opatch folder'ı oku oracle_home'u oku
# ssh ile bağlan
# cd patch path
# export falan 
# opatch lsinventory falan ...
# eğer patch geçeceğimiz patch ismi yoksa 
# opatch apply'de
# 
#-----------

## SSH ile bağlan NodeManager'ı ayağa kaldır.
## NM üzerinden AdminServer'ı ayağa kaldır.
## wlst ile managedServer'ları ayağa kaldır.


