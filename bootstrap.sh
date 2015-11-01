##
## Install a Proteowizard machine
## Steffen Neumann <sneumann (at) ipb-halle.de>
## License: LGPL >= 2
##


##
## The first part of the script should be run as root, 
## the rest as user vagrant
## http://stackoverflow.com/questions/16768777/can-i-switch-user-in-vagrant-bootstrap-shell-script/22947716#22947716
## 

case $(id -u) in
    0) echo first pass: running as root

	## Freshen package index and update to latest
	apt-get update
	apt-get dist-upgrade -y 
	apt-get install python-software-properties
	apt-get install -y xvfb 
	apt-get install -y lynx joe

	# Set timezone
	echo "Europe/Berlin" | tee /etc/timezone
	dpkg-reconfigure --frontend noninteractive tzdata

	# set locale
	export LANGUAGE=en_US.UTF-8
	export LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
	locale-gen en_US.UTF-8
	dpkg-reconfigure locales

	## http://askubuntu.com/questions/476895/what-do-i-do-for-dependencies-installing-wine1-7-on-14-04
	dpkg --add-architecture i386

	# Add Wine PPA
	add-apt-repository -y ppa:ubuntu-wine/ppa 
	apt-get update 

	## get wine and winetricks
	aptitude install -y wine1.7 winetricks ## --without-recommends

	## https://programmaticponderings.wordpress.com/2013/12/19/scripting-linux-swap-space/
	## size of swapfile in megabytes
	swapsize=2048
 
	# does the swap file already exist?
	grep -q "swapfile" /etc/fstab
 
	# if not then create it
	if [ $? -ne 0 ]; then
	    echo 'swapfile not found. Adding swapfile.'
	    fallocate -l ${swapsize}M /swapfile
	    chmod 600 /swapfile
	    mkswap /swapfile
	    swapon /swapfile
	    echo '/swapfile none swap defaults 0 0' >> /etc/fstab
	else
	    echo 'swapfile found. No changes made.'
	fi

	## script calling itself as the vagrant user
	sudo -u vagrant -i $0 
        ;;

    *) echo second pass: running as vagrant

	echo "Defaulting to 32bit Win7"
	export WINEARCH=win32

#	echo "Setting WINE to Win7" 
#	xvfb-run winetricks settings win7

	echo "Getting Visual C++ 2008 runtime"
	xvfb-run winetricks -q vcrun2008
	## Using native,builtin override for following DLLs: atl90 msvcm90 msvcp90 msvcr90 vcomp90 ## STN: maybe override ? msvcp110.dll
	echo "Getting Visual Studio 2012 runtime"
	## required for VCOMP110.DLL later in msconvert.exe
	xvfb-run wine /vagrant/vcredist_x86.exe  /quiet

	## vcredist 2012 installation has a permission denied issue on wine:
	## https://social.msdn.microsoft.com/Forums/en-US/ad438372-5750-45f1-82e7-8a3e53b12f8e/microsoft-vc-2012-redistributable-x86-access-denied-please-help?forum=vssetup

#	if stat -c %A  './.wine/drive_c/users/Public/Application Data/Package Cache/{33d1fd90-4274-48a1-9bc1-97e33d9c2d6f}' | grep -- 'd---------' ; then 
	    ## This is a failure in automatic Visual Studio 2012 runtime installation
	    ## Workaround described by Jakob Nixdorf
	    ## https://appdb.winehq.org/objectManager.php?sClass=version&iId=31321 
	    echo "Manually extracting vcomp110.dll"

	    mkdir vcredist_x86_tmp
	    cd vcredist_x86_tmp

	    cabextract /vagrant/vcredist_x86.exe

	    cabextract a2
	    cp 'F_CENTRAL_msvcp110_x86' ~/.wine/drive_c/windows/system32/msvcp110.dll
	    cp 'F_CENTRAL_msvcr110_x86' ~/.wine/drive_c/windows/system32/msvcr110.dll

	    cabextract a3
	    cp 'F_CENTRAL_vcomp110_x86' ~/.wine/drive_c/windows/system32/vcomp110.dll

	    cd ..
	    rm -rf  vcredist_x86_tmp

#	fi 
	
	echo "Installing .NET 3.5sp1"
	mkdir -p /home/vagrant/.cache/winetricks/dotnet30
	cp /vagrant/netframework3.exe /home/vagrant/.cache/winetricks/dotnet30

	mkdir -p /home/vagrant/.cache/winetricks/msxml3
	cp /vagrant/msxml3.msi /home/vagrant/.cache/winetricks/msxml3

	xvfb-run winetricks -q dotnet35sp1

	echo "Installing .NET 4.0"
	xvfb-run winetricks -q dotnet40

	echo "Using native mfc90.dll"
	cp .wine/drive_c/windows/winsxs/x86_Microsoft.VC90.MFC_1fc8b3b9a1e18e3b_9.0.30729.1_x-ww_405b0943/mfc90.dll .wine/drive_c/windows/system32 

	export WINEDLLOVERRIDES="mfc90=n,msvcr110=n,msvcp110=n,vcomp110=n"

	echo "And FINALLY install pwiz"
	xvfb-run msiexec /i  /vagrant/pwiz-setup-3.0.7374-x86.msi /quiet

	## and check the success:
	xvfb-run wine ".wine/drive_c/Program Files/ProteoWizard/ProteoWizard 3.0.7374/msconvert.exe"

	echo "Installing IE8 as CompassXport prerequisite"
	xvfb-run winetricks -q ie8

	echo "Also install Bruker CXP while at it"
	xvfb-run wine "/vagrant/CompassXport_3.0.9.2_Setup.exe" /S /v/qn 

	## The mfc90.dll is nowhere properly installed ?!
	## Copy manually from some temporary (?) directory 
	
	cp "/home/vagrant/.wine/drive_c/windows/winsxs/x86_Microsoft.VC90.MFC_1fc8b3b9a1e18e3b_9.0.30729.1_x-ww_405b0943/mfc90.dll" "/home/vagrant/.wine/drive_c/Program Files/Bruker Daltonik/CompassXport"
        ;;
esac

exit


## Some tests locally

sh /vagrant/testconvert.sh



