
#!/bin/bash

#Assign variables
ACTION=${1}
VERSION='0.1.0'

#Show version function

function show_version(){
echo $VERSION
}

#Create a file
function create_file(){

touch "${1}-rds-message.txt"
touch "${1}-ecoweb1-identity.json"

#Append to rds-message.txt
nc -vz eco-tech-db-one.cppeadxnj69d.us-east-1.rds.amazonaws.com 3306 >> rds-message.txt

#Append to ecoweb file
curl http://169.254.169.254/latest/dynamic/instance-identity/document/ >> ecoweb1-identity.json

}


#Display help function
function display_help(){

cat << EOF

Usage: ${0} {-c|--create|-h|--help|-v|--version} {metadata.sh>

Options:
	-c|--create create a new file
	-h|--help display the command help
	-v|--versoin Shows current version

Examples:
	Create a new file 
	$ ${0} -c
	
	Display help:
	$ ${0} -h

	Show version:
	$ ${0} -v
EOF
}

case "$ACTION" in
	-c|--create)
	create_file
	;;
	-h|--help)
	display_help
	;;
	-v|--version)
	show_version
	;;
	*)
	echo "Usage ${0} {-c|-h|-v}"
	exit 1

esac
