#!/bin/bash
#
# Authors:
#   Connor Glosser <glosser1@gmail.com>
#
# Description:
#   A post-installation bash script for Ubuntu
#
# Legal Preamble:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

# tab width
tabs 4
clear

##----- Import Functions -----#

dir="$(dirname "$0")"

. $dir/functions/check
#. $dir/functions/cleanup
#. $dir/functions/codecs
#. $dir/functions/configure
#. $dir/functions/development
#. $dir/functions/favourites
#. $dir/functions/thirdparty
. $dir/functions/update
#. $dir/functions/utilities

#----- Fancy Messages -----#
show_error(){
echo -ne "\033[1;31m$@\033[m" 1>&2
}
show_info(){
echo -ne "\033[1;32m$@\033[0m"
}
show_warning(){
echo -ne "\033[1;33m$@\033[0m"
}
show_question(){
echo -ne "\033[1;34m$@\033[0m"
}
show_success(){
echo -ne "\033[1;35m$@\033[0m"
}
show_header(){
echo -ne "\033[1;36m$@\033[0m"
}
show_listitem(){
echo -ne "\033[0;37m$@\033[0m"
}

# Main
function main {
    eval `resize`
    MAIN=$(whiptail \
        --notags \
        --title "Ubuntu Post-Install Script" \
        --menu "\nWhat would you like to do?" \
        --cancel-button "Quit" \
        $LINES $COLUMNS $(( $LINES - 12 )) \
        update      'Perform system update' \
        favourites  'Install favourite applications' \
        utilities   'Install favourite system utilities' \
        development 'Install favourite development tools' \
        codecs      'Install Ubuntu Restricted Extras' \
        thirdparty  'Install third-party applications' \
        configure   'Configure system' \
        cleanup     'Cleanup the system' \
        3>&1 1>&2 2>&3)
     
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        clear && $MAIN
    else
        clear && quit
    fi
}

# Quit
function quit {
    if (whiptail --title "Quit" --yesno "Are you sure you want quit?" 10 60) then
        show_success "\nScript complete.\n"
        echo "Thank you for using CHAOS!\n"
        exit 99
    else
        clear && main
    fi
}

##RUN
check #&& main

#END OF SCRIPT
