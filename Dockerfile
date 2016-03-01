FROM ubuntu

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="Install proteowizard under wine in Docker."

## Freshen package index and update to latest
RUN apt-get update \
	&& apt-get dist-upgrade -y

## Get dummy X11 server
RUN apt-get install -y xvfb wget xinit

## http://askubuntu.com/questions/476895/what-do-i-do-for-dependencies-installing-wine1-7-on-14-04
RUN dpkg --add-architecture i386

# Add Wine PPA
RUN apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:ubuntu-wine/ppa \
	&& apt-get update

## get wine and winetricks
RUN apt-get install -y wine1.8

## overwrite with updated winetricks, version does not provide
## vcrun2013
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/bin/winetricks \
	&& chmod +x /usr/bin/winetricks 


# clean up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Inspired by: https://github.com/suchja/
#
# first create user and group for all the wine stuff
RUN addgroup --system wine \
  && adduser \
	--home /home/wine \
	--disabled-password \
	--shell /bin/bash \
	--gecos "user for running a wine application" \
	--ingroup wine \
	--quiet \
	wine

# Wine really doesn't like to be run as root, so let's use a non-root user
USER wine
ENV HOME /home/wine
ENV WINEPREFIX /home/wine/.wine
ENV WINEARCH win32

# Install .NET Framework 4.0 

RUN wine wineboot && xvfb-run winetricks --unattended vcrun2008 vcrun2010 vcrun2013 dotnet35sp1 dotnet40

ADD get_msconvert.sh /tmp
RUN /tmp/get_msconvert.sh

RUN xvfb-run -a msiexec /i  /tmp/pwiz-setup-*.msi /quiet

# Use wine's home dir as working dir
WORKDIR "/home/wine/.wine/drive_c/Program Files/ProteoWizard/ProteoWizard 3.0.9393"

# Define Entry point script
ENTRYPOINT [ "wine", "./msconvert.exe" ]

