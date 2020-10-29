#!/usr/bin/env bash
###########################################################
## FakeSudoSetup Tool                                    ##
## Author on Muhammed Taha                               ##
## Telegram Profile = https://t.me/U5M4NA6A              ##
###########################################################
__ScriptVersion="1.0";

main()
{
clear
echo "======================================================================="
echo "#  ███████╗ █████╗ ██╗  ██╗███████╗███████╗██╗   ██╗██████╗  ██████╗  #"
echo "#  ██╔════╝██╔══██╗██║ ██╔╝██╔════╝██╔════╝██║   ██║██╔══██╗██╔═══██╗ #"
echo "#  █████╗  ███████║█████╔╝ █████╗  ███████╗██║   ██║██║  ██║██║   ██║ #"
echo "#  ██╔══╝  ██╔══██║██╔═██╗ ██╔══╝  ╚════██║██║   ██║██║  ██║██║   ██║ #"
echo "#  ██║     ██║  ██║██║  ██╗███████╗███████║╚██████╔╝██████╔╝╚██████╔╝ #"
echo "#  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝  #"
echo "======================================================================="
getargs "$@"
[[ "$install" == "true" ]] && install_fakesudo;
[[ "$remove" == "true" ]] && remove_fakesudo;
}

usage()
{
  echo """Usage :  $0 [options] [--]

  Options:

    (Setup)
        -i   Install FakeSudo
        -u   Uninstall Fakesudo
"""
}

getargs()
{
    while getopts "H:hiuv" opt
    do
    case $opt in
    h)
        usage;
        exit 0
    ;;
    v)
        echo "$0 -- Version $__ScriptVersion";
        exit 0;
    ;;
    i)   install="true" ;;
    u)    remove="true" ;;
    *)
        echo -e " \n Option does not exist \n "
        usage;
        exit 1
    ;;
    esac
    done
    shift "$((OPTIND - 1))"
}

install_fakesudo()
{
	if [ "$(cat /usr/bin/sudo | head -n 3 | tail -n 1 | cut -f4 -d " ")" == "fakesudo" ]
		then
			echo "FakeSudo already installed"
		else
			echo "Installing fakesudo.. Please Wait..."
	   		sleep 2
			mkdir $HOME/SudoBackup/ 2> /dev/null
			mv /usr/bin/sudo $HOME/SudoBackup/sudo.backup
			cp -R $PWD/sudo /usr/bin/
			chmod 755 /usr/bin/sudo
	fi
    
	read -p "Press enter to complete setup, Type "sudo" to check.."
	case $1 in
	* ) 
	    	exit
	;;
    	esac
}

remove_fakesudo()
{
    echo "Uninstalling fakesudo.. Please Wait..."
    sleep 2
    rm -r /usr/bin/sudo
    cp $HOME/SudoBackup/sudo.backup /usr/bin/sudo
    chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo
    read -p """Press enter to continue, Type "sudo" to check.."""
    case $1 in
    * ) 
    	exit
    ;;
    esac
}

main "$@"
