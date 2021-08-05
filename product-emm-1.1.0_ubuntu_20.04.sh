# ----------------------------------------------------------------------------
#
# Package           : product-emm
# Version           : 1.1.0
# Source repo       : https://github.com/wso2-attic/product-emm-1.1.0
# Tested on         : ubuntu_20.04
# Script License    : Apache License, Version 2 or later
# Maintainer        : Santosh Kulkarni <santoshkulkarni70@gmail.com> / Priya Seth<sethp@us.ibm.com>
#
# Disclaimer        : This script has been tested in non-root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------
#!/bin/bash


export REPO=https://github.com/wso2-attic/product-emm-1.1.0

if [ -z "$1" ]; then
  export VERSION="1.1.0"
else
  export VERSION="$1"
fi

sudo apt-get update
sudo apt-get install openjdk-8-jdk wget git -y
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-ppc64el/
sudo apt install  -y maven
mvn -version

if [ -d "product-emm" ] ; then
  rm -rf product-emm
fi

git clone ${REPO}

## Build and test product-emm
cd product-emm
git checkout ${VERSION}
ret=$?

if [ $ret -eq 0 ] ; then
  echo "$Version found to checkout "
else
  echo "$Version not found "
  exit
fi

mvn clean install
