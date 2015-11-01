##
## Install a Proteowizard machine
## Steffen Neumann <sneumann (at) ipb-halle.de>
## License: LGPL >= 2
##


## Some tests locally



wine /home/vagrant/.wine/drive_c/Program\ Files/ProteoWizard/ProteoWizard\ 3.0.7374/msconvert.exe /vagrant/neg-MM8_1-A,1_01_376.d

wine /home/vagrant/.wine/drive_c/Program\ Files/ProteoWizard/ProteoWizard\ 3.0.7374/msconvert.exe /vagrant/amlodypina_30min.d.raw

wine /home/vagrant/.wine/drive_c/Program\ Files/Bruker\ Daltonik/CompassXport/CompassXport.exe -a /vagrant/neg-MM8_1-A,1_01_376.d -o /vagrant/neg-MM8_1-A,1_01_376-CXP.mzML -mode 2 



