#!/bin/bash

#Common username and password for all servers
Password=password
Username=root

#It will accept all the variables with comma(,)
servers-list = "$@"

#It will appending comma replace with a new line that will append to file
echo "$servers-list" | sed -e $'s/,/\\\n/g' > servers
HOSTFILE=servers
services=""

#Termindate the all processes
echo "Start terminating processes...."
for server in $(cat $HOSTFILE)
        do
                echo "$server"
                echo "---------------"
                for tools in $services
                        do
                                sshpass -p $Password ssh -o StrictHostKeyChecking=no $Username@$server ps -eo pid,args | grep $tools | grep -v grep | awk '{print $1}' >> pids
                                pid_list=`cat pids`
                pid_list=`echo $pid_list | sed -e $'s/\\\n/ /g'`
                                rm -rf pids

                if [ -n "$pid_list" ]
                                then
                                        echo "$tools >> PIDs: $pid_list"
                                        sshpass -p $Password ssh -o StrictHostKeyChecking=no $Username@$server kill -9 $pid_list >> /dev/null 2>& 1
                                fi
                done
                echo ""
     done
