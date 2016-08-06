#!/bin/bash
# Helpful tool for managing updates to local/remote Subversion checkouts of TSheets projects.
#
# Example Usage: 
# tsheets_update.sh all
# tsheets_update.sh www
# tsheets_update.sh www_local 
# tsheets_update.sh www_remote
#######################################################################################
# Configuration - General
#######################################################################################
remote_tsheets_server_username="kbanbrook" # assumes that both shazdev and lntxweb1 use same username
#######################################################################################
# WEB DASHBOARD
#######################################################################################
# Configuration - Web Dashboard (Local)
declare -a web_dashboard_local_subversion_dirs
web_dashboard_local_subversion_dirs[0]="/Users/katiebanbrook/Sites/App"
#web_dashboard_local_subversion_dirs[1]="/Users/katiebanbrook/Sites/lntxweb1"
#web_dashboard_local_subversion_dirs[2]="/Users/katiebanbrook/Sites/shazdev"
# Configuration - Web Dashboard (Remote - shazdev.tsheets.com)
declare -a web_dashboard_remote_shazdev_subversion_dirs
web_dashboard_remote_shazdev_subversion_dirs[0]="/var/www/kbanbrook.tsheets.com"
# Configuration - Web Dashboard (Remote - lntxweb1.tsheets-dev.com)
declare -a web_dashboard_remote_lntxweb1_subversion_dirs
web_dashboard_remote_lntxweb1_subversion_dirs[0]="/var/www/kbanbrook.tsheets-dev.com"
#######################################################################################
# WWW SITE
#######################################################################################
# Configuration - WWW Site (Local)
declare -a www_site_local_subversion_dirs
www_site_local_subversion_dirs[0]="/Users/katiebanbrook/Sites/Website"
# Configuration - WWW Site (Remote - shazdev.tsheets.com)
declare -a www_site_remote_shazdev_subversion_dirs
www_site_remote_shazdev_subversion_dirs[0]="/var/www/beta-kbanbrook.tsheets.com"
# Configuration - WWW Site (Remote - lntxweb1.tsheets-dev.com)
declare -a www_site_remote_lntxweb1_subversion_dirs
www_site_remote_lntxweb1_subversion_dirs[0]="/var/www/beta-kbanbrook.tsheets-dev.com"
#######################################################################################
# NOTHING BELOW THIS LINE SHOULD NEED TO BE EDITTED!
#######################################################################################
script_name="[TSheets Subversion Update Script]"
# Define some custom colors used for this script
red_text=`tput setaf 1`
green_text=`tput setaf 2`
reset_text=`tput sgr0`
function help {
    echo "Usage: tsheets_update.sh <APP_PROJECT>"
    echo ""
    echo "Valid Group Projects: all, web_dashboard, www"
    echo "Valid Individual Projects: android, iphone, web_dashboard_local, web_dashboard_remote, www_local, www_remote"
    echo ""
    echo "Example: tsheets_update.sh all"
    echo "Example: tsheets_update.sh web_dashboard"
    exit
}
function abort {
    echo "${red_text}$script_name > ABORTED${reset_text}"
    exit
}
function update_all {
    echo "${green_text}$script_name > Updating all projects...${reset_text}"
    update_web_dashboard
    update_www
}
function update_web_dashboard {
    echo "${green_text}$script_name > Updating all web dashboard projects ...${reset_text}"
    update_web_dashboard_remote # Updating the remote checkouts first to avoid issues with rsync
    update_web_dashboard_local
}
function update_www {
    echo "${green_text}$script_name > Updating all www site projects ...${reset_text}"
    update_www_remote # Updating the remote checkouts first to avoid issues with rsync
    update_www_local
}
function update_web_dashboard_local {
    echo "${green_text}$script_name > Updating TSheets Web Dashboard projects (local) ...${reset_text}"
    for subversion_directory in "${web_dashboard_local_subversion_dirs[@]}"
    do
        :
        echo "${green_text}$script_name > Updating project dir: $subversion_directory ...${reset_text}"
        svn_cmd="svn update $subversion_directory"
        $svn_cmd
    done
}
function update_web_dashboard_remote {
    # Handle shazdev.tsheets.com (PROD)
    echo "${green_text}$script_name > Updating TSheets Web Dashboard projects (remote: shazdev) ...${reset_text}"
    for subversion_directory in "${web_dashboard_remote_shazdev_subversion_dirs[@]}"
    do
        :
        echo "${green_text}$script_name > Updating project dir: $subversion_directory ...${reset_text}"
        svn_cmd="ssh $remote_tsheets_server_username@shazdev.tsheets.com svn update $subversion_directory"
        $svn_cmd
    done
    # Handle lntxweb1.tsheets-dev.com (DEV)
    echo "${green_text}$script_name > Updating TSheets Web Dashboard projects (remote: lntxweb1) ...${reset_text}"
    for subversion_directory in "${web_dashboard_remote_lntxweb1_subversion_dirs[@]}"
    do
        :
        echo "${green_text}$script_name > Updating project dir: $subversion_directory ...${reset_text}"
        svn_cmd="ssh $remote_tsheets_server_username@lntxweb1.tsheets-dev.com svn update $subversion_directory"
        $svn_cmd
    done
}
function update_www_local {
    echo "${green_text}$script_name > Updating TSheets WWW Site projects (local) ...${reset_text}"
    for subversion_directory in "${www_site_local_subversion_dirs[@]}"
    do
        :
        echo "${green_text}$script_name > Updating project dir: $subversion_directory ...${reset_text}"
        svn_cmd="svn update $subversion_directory"
        $svn_cmd
    done
}
function update_www_remote {
    # Handle shazdev.tsheets.com (PROD)
    echo "${green_text}$script_name > Updating TSheets WWW Site projects (remote: shazdev) ...${reset_text}"
    for subversion_directory in "${www_site_remote_shazdev_subversion_dirs[@]}"
    do
        :
        echo "${green_text}$script_name > Updating project dir: $subversion_directory ...${reset_text}"
        svn_cmd="ssh $remote_tsheets_server_username@shazdev.tsheets.com svn update $subversion_directory"
        $svn_cmd
    done
    # Handle lntxweb1.tsheets-dev.com (DEV)
    echo "${green_text}$script_name > Updating TSheets WWW Site projects (remote: lntxweb1) ...${reset_text}"
    for subversion_directory in "${www_site_remote_lntxweb1_subversion_dirs[@]}"
    do
        :
        echo "${green_text}$script_name > Updating project dir: $subversion_directory ...${reset_text}"
        svn_cmd="ssh $remote_tsheets_server_username@lntxweb1.tsheets-dev.com svn update $subversion_directory"
        $svn_cmd
    done
}
function main {
    app_project=$1
    if [ -z "$app_project" ]; then
        app_project="all"
    fi
    echo "${green_text}$script_name > BEGIN"
    case $app_project in
        all ) update_all;;
        web_dashboard ) update_web_dashboard;;
        www ) update_www;;
        web_dashboard_local ) update_web_dashboard_local;;
        web_dashboard_remote ) update_web_dashboard_remote;;
        www_local ) update_www_local;;
        www_remote ) update_www_remote;;
        * ) echo "${red_text}$script_name > ERROR: Invalid application project selected ($app_project)! See 'help' for options.${reset_text}"; abort;;
    esac
}
# Script Body
if [ "$1" == "help" ]; then
    help
else
    main $1
fi
echo "${green_text}$script_name > END${reset_text}"
