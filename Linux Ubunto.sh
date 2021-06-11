sudo apt install vim #To download vim editor

####paths ####
cd
ls
cd Desktop
cd Scripting 

#### creating .sh ####

vim shell.sh #create file called shell
#hit I to insert text to editor

#### What to type in editor ####

#!/bin/bash # AKA sharp bang or shebang
echo “Scripting is fun";

####     end of editor      ####

hit esc button #escape button
:w # to save
:x # to exit

#### To run a script ####
chmod 755 script.sh
./script.sh


################################################################################
####    if condition            ####

#!/bin/bash
MY_SHELL="bash"

if [ "$MY_SHELL" = "bash" ] #make sure you put spaces otherwise won't work 
then
	echo "success"
fi #closes loop


####    if/else condition            ####

#!/bin/bash
MY_SHELL="csh"

if [ "$MY_SHELL" = "bash" ]
then
        echo "You seem to like the bash shell."
elif [ "$MY_SHELL" = "csh" ]
then
        echo "You seem to like the csh shell."
else
        echo "You don't seem to like the bash or csh shells."
fi

#### for loop ####
#!/bin/bash

COLORS="red green blue"

For COLOR in $COLORS
do
	echo "COLOR: $COLOR"
done

####Add date to file name ####
#!/bin/bash

#this renames all pics that end with jpg to the date+.jpg
PICTURES=$(ls *jpg)
DATE=$(date +%F)

for PICTURE in $PICTURES
do
        echo "Renaming ${PICTURE} to ${DATE}-${PICTURE}"
        mv ${PICTURE} ${DATE}-${PICTURE}
done

############################################################################
####exit status and return codes ####
#!/bin/bash
ls /not/here
echo "$?" #contains the return code of the previously executed command
#non 0 exit codes indicated an error, so 0 means no error, there are 0-255 exit status

#### -eq ####
#!/bin/bash

HOST="google.com"

ping -c 1 $HOST #1 packet is sent to server

if [ "$?" -eq "0" ]
then
  echo "$HOST reachable."
else
  echo "$HOST unreachable."
fi

#### -nq ####
#!/bin/bash

HOST="google.com"

ping -c 1 $HOST
RETURN_CODE=$? #this is the return code

if [ "$RETURN_CODE" -ne "0" ]
then
  echo "$HOST unreachable."
fi


####&& and####
only execute if previous command succeeds
only run if previous command exits with 0 exit status

#!/bin/bash

HOST="google.com"

ping -c 1 $HOST && echo "$HOST reachable." ##if first command runs then 2nd command will run



#### || or ####
only 1 of 2 commands will execute 

#!/bin/bash

HOST="google.com"

ping -c 1 $HOST || echo "$HOST unreachable." # if first command fails then 2nd command will run 


####control exit status number ####
#!/bin/bash

HOST="google.com"

ping -c 1 $HOST

if [ "$?" -ne "0" ]
then
  echo "$HOST unreachable."
  exit 1
fi

exit 0

################################################################################
####create functions ####
#!/bin/bash

function hello() {   #hello() is the function name
    echo "Hello!"
}

hello #this basically has to be part of the code so the functions gets called and executed, otherwise nothing happens

OUTPUT: Hello!

####calling multiple functions ####
#!/bin/bash

function hello() {
    echo "Hello!"
    now
}

function now() {
    echo "It's $(date +%r)" #gives you the date now
}

hello #as we see hello has to be the last so that both hello() and now() are read otherwise there will be error

OUTPUT:
Hello!
It's 03:05:14 PM

####Positinal Parameters####
#!/bin/bash

function hello() {
    echo "Hello $1" 
}

hello Jason Derulo

OUTPUT: 
hello Jason #if $1
hello Derulo #if $2

#if $@
hello Jason
hello Derulo

#### Global Variable ####
my_function() {
    GLOBAL_VAR=1
}

# GLOBAL_VAR not available yet.
echo "GLOBAL_VAR value BEFORE my_function called: $GLOBAL_VAR"

my_function

# GLOBAL_VAR is NOW available
echo "GLOBAL_VAR value AFTER my_function called: $GLOBAL_VAR"

OUTPUT:
GLOBAL_VAR value BEFORE my_function called: $GLOBAL_VAR:
GLOBAL_VAR value AFTER my_function called: $GLOBAL_VAR: 1

#### Local Variable ####
#!/bin/bash

my_function() {
    local LOCAL_VAR=1
    echo "LOCAL_VAR can be accessed inside of the function: $LOCAL_VAR"
}

my_function

# LOCAL_VAR is not available outside of the function.
echo "LOCAL_VAR can NOT be accessed outside of the function: $LOCAL_VAR"

OUTPUT:
LOCAL_VAR can be accessed inside of the function: 1
LOCAL_VAR can NOT be accessed outside of the function: 

################################################################################
####wild cards/globbing####
*.txt #finds all txt files eg. ls *.txt
a* #finds all files starting with a
a*.txt #finds all files starting with a and are txt 

?.txt #? matches exactly 1 character, so h.txt or j.txt etc
a? #finds all files starting with a plus another character
a?.txt 
??.txt #matches 2 characters

[aeiou] # if you want a file to have only 1 vowel use this
ca[nt]* # starts with ca and followed by a n or t, eg can , cat,candy,catch

[!aeiou]* # files that dont start with vowels
[a-g]* # shows all files starting with a,b,c etc
[3-6]

[[:alpha:]]
[[:alnum:]]
[[:digit:]]
[[:lower:]]
[[:space:]]
[[:upper:]]

*\? # shows files ending with ?

c[aeiou]t # cat, cot

*[[:digit:]] #blues.mp3    jazz.mp3


#wild cards in shell scripts#
#!/bin/bash
cd /var/www #go to this directory
for FILE in *.html # for files that have .html
do
	echo "Copying $FILE"
	cp $FILE /var/www-just-html #copy them into this directory
done


OUTPUT:
Copying about.html
Copying contact.html
Copying index.html

#another way to do it #
#!/bin/bash

for FILE in /var/www/*.html
do
	echo "Copying $FILE"
	cp $FILE /var/www-just-html #copy them into this directory
done

OUTPUT:
Copying /var/www/about.html
Copying /var/www/contact.html
Copying /var/www/index.html

################################################################################
####Case statements####

#### basic eg ####
#!/bin/bash

case "$1" in   #### $1 means if you type: file.sc start in command ,$0 is file.sc and $1 is start
    start|START)
        /usr/sbin/sshd
        ;;
    stop|STOP)
        kill $(cat /var/run/sshd.pid)
        ;;
    *)
        echo "Usage: $0 start|stop" ; exit 1
        ;;
esac


#### multiple inputs ####
#!/bin/bash

read -p "Enter y or n:" ANSWER #when you type file.sc you get asked "Enter y or n:"

case "$ANSWER" in
    [yY]|[yY][eE][sS])
        echo "You answered yes."
        ;;
    [nN]|[nN][oO])
        echo "You answered no."
        ;;
   *)
        echo "Invalid answer."
        ;;
esac


####another example ####
#!/bin/bash

read -p "Enter y or n: " ANSWER

case "$ANSWER" in
    [yY]*)  #if first input is y or Y then accepted 
        echo "You answered yes."
        ;;
   *)
        echo "You answered something else."
        ;;
esac


################################################################################
####logging####

Write a shell script that displays one random number to the screen and also generates a syslog message 
with that random number. Use the "user" facility and the "info" facility for your messages.
Hint: Use $RANDOM

#!/bin/bash

MESSAGE="Random number: $RANDOM"

echo "$MESSAGE"
logger -p user.info "$MESSAGE"

OUTPUT:
Random number: 17191

####another example####
Modify the previous script so that it uses a logging function. 
Additionally tag each syslog message with "randomly" and include the process ID. Generate 3 random numbers.
#!/bin/bash 

function my_logger() {
  local MESSAGE=$@
  echo "$MESSAGE"
  logger -i -t randomly -p user.info "$MESSAGE"
}

my_logger "Random number: $RANDOM"
my_logger "Random number: $RANDOM"
my_logger "Random number: $RANDOM"


OUTPUT:
Random number: 16591
Random number: 4478
Random number: 1521


################################################################################
####while loops####
#!/bin/bash

INDEX=1
while [ $INDEX -lt 6 ] #less than is -lt
do
  echo "Count-${INDEX}"
  ((INDEX++))
done
OUTPUT:
Count-1
Count-2
Count-3
Count-4
Count-5

####another example ####
#!/bin/bash

while [ "$CORRECT" != "y" ]
do
  read -p "Enter your name: " NAME
  read -p "Is ${NAME} correct? " CORRECT
done

OUTPUT:
Enter your name: ahmed
Is ahmed correct? n
Enter your name: ahmed
Is ahmed correct? y # loop stops

################################################################################
####Debugging####
#!/bin/bash -x #-x means debugging starts

TEST_VAR="test"
echo "$TEST_VAR"

OUTPUT:
+ TEST_VAR=test
+ echo test
test

####another example -x +x ####
#!/bin/bash

TEST_VAR="test"
set -x #start debug
echo $TEST_VAR
set +x  #end debug
hostname

OUTPUT:
+echo test
test
+ set +x
linuxsvr

#!/bin/bash -e #exits on error 


################################################################################
#### Rename file ####
mv file1.txt file2.txt #For example, to rename the file file1.txt as file2.txt 

#### sort by date modified ####
ls -lt

####copy a file ####
cp file.txt file_backup.txt

####Display contents of a file ####
cat file.txt



