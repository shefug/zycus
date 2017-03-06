#!/bin/bash
#####################################################################
#assuming passwordless login is there and server hostname is resolved
#excuting the script like :-
#/bin/bash <script name> <mention the hostnames seperated with ,>
#Ex: /bin/bash shefali_script.sh hostname1,hostname2 
#####################################################################
#passing the argument in the variable
list_hostname=$1
#counting the number of , in the argument for knowing the number of hostnames and storing the value in the variable
count=`echo $list_hostname | grep -o "\," | wc -l`
#toltal number of hostnames will be more than 2 of the number of ,
total_hostnames=$(($count + 2))
#providing the user prompt for entering the command 
echo "mention the command to execute on all servers ::"
read command
#initializing the variable for loop with 0
var=0
#executing the command mentioned by the user in all the servers via ssh
while [ $var -le $total_hostnames ]
do
  #getting the hostname from the argument using the "awk" comand
  hostname=`echo $list_hostname |awk -F"," '{print $'$var'}'`
  echo "executing command in the machine :: $hostname"
  #this is used for executing the command in the remote machine
  ssh root@$hostname $command
  var=$(($var + 1))
done
