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

