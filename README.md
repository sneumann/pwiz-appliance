pwiz-appliance

Proteowizard is a phantastic project and a cross-platform toolkit 
for mass spectrometry not only in proteomics, but also metabolomics
and the environmental sciences. 

Unfortunately the DLLs required to convert from vendor formats 
to e.g. the open mzML format are only available under Windows. 
The only option to convert vendor files under linux is to use Wine.

This pwiz-appliance uses Vagrant to create a virtual machine image,
download pwiz and install it under wine. 

For an upstream documentation of pwiz under wine, see:
http://tools.proteomecenter.org/wiki/index.php?title=Msconvert_Wine

The following files are required, but can not be distributed with 
this appliance:

````
-rwxrw-r-- 1 sneumann sneumann   45699031 Nov  1 09:37 CompassXport_3.0.9.2_Setup.exe
-rw-rw-r-- 1 sneumann sneumann   54779904 Nov  1 09:40 pwiz-setup-3.0.7374-x86.msi
-rw-rw-r-- 1 sneumann sneumann    1070592 Nov  1 10:12 msxml3.msi
-rw-rw-r-- 1 sneumann sneumann    6554576 Nov  1 10:12 vcredist_x86.exe
-rw-rw-r-- 1 sneumann sneumann   52770576 Nov  1 10:12 netframework3.exe
````

CompassXport can be obtained from:
https://www.bruker.com/de/service/support-upgrades/software-downloads/mass-spectrometry.html

Proteowizard can be obtained from:
http://proteowizard.sourceforge.net/downloads.shtml

msxml3.msi can be found here:
http://repository.playonlinux.com/divers/msxml3.msi

vcredist_x86.exe is here:
https://www.microsoft.com/en-us/download/confirmation.aspx?id=5555

(or for a direct download: https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe )

And get netframework3.exe from http://www.oldversion.com/download-.Net-Framework-3.0.html 

---------------------------------------------------------------

A very similar project is this environment from John Chilton:
https://github.com/jmchilton/proteomics-wine-env


