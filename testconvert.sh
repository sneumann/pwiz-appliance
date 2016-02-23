##
## Install a Proteowizard machine
## Steffen Neumann <sneumann (at) ipb-halle.de>
## License: LGPL >= 2
##


## Some tests locally


## Automagically find msconvert in [HKEY_LOCAL_MACHINE\Software\Classes\Directory\shell\Open with MSConvertGUI\command]

## wine regedit /E - '' | grep -i msconvert
## wine regedit /E - '[HKEY_LOCAL_MACHINE\Software\Classes\Directory\shell\Open with MSConvertGUI\command]'





wine /home/vagrant/.wine/drive_c/Program\ Files/ProteoWizard/ProteoWizard\ 3.0.9098/msconvert.exe /vagrant/neg-MM8_1-A,1_01_376.d -o /vagrant

wine /home/vagrant/.wine/drive_c/Program\ Files/ProteoWizard/ProteoWizard\ 3.0.9098/msconvert.exe /vagrant/amlodypina_30min.d.raw -o /vagrant 

wine /home/vagrant/.wine/drive_c/Program\ Files/ProteoWizard/ProteoWizard\ 3.0.9098/msconvert.exe /vagrant/5ul_LA1777-a.wiff -o /vagrant

#wine /home/vagrant/.wine/drive_c/Program\ Files/Bruker\ Daltonik/CompassXport/CompassXport.exe -a /vagrant/neg-MM8_1-A,1_01_376.d -o /vagrant/neg-MM8_1-A,1_01_376-CXP.mzML -mode 2 



