# Generate reRECO data
To produce reRECO files, first you need to generate config via following command.
```
cmsrel CMSSW_13_1_0
cd CMSSW_13_1_0/src
git clone https://github.com/tihsu99/Generate_reReco.git
cmsenv
cd Generate_reReco
sh test_cmsDriver_miniaod.sh
```
To produce files contain HLT information
```
hlt_cmsDriver_miniaod.sh # Combine with test_cmsDriver_miniaod.sh once test is done
```
After testing it locally, you can submit it to crab
```
cmsRun CrabSubmit.py
```


