#!/bin/bash
pushd $(dirname "${0}") > /dev/null
basedir=$(pwd -L)
# Use "pwd -P" for the path without links. man bash for more info.
popd > /dev/null
export RAILS_ROOT=`dirname ${basedir}`

# detect if we're on the web server
sname=`basename $RAILS_ROOT`
if [ $sname == "brasilblogs.net" ]
then
    echo "===On web server, changing rails environment==="
    export RAILS_ENV=production
fi
cd ${basedir}
cd ..
rails runner ${basedir}/crawl_facebook.rb