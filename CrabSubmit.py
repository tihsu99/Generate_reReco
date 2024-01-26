#!/bin/env python
import os

#
# Example script to submit to crab
#
submitVersion = "2024-01-19" # add some date here

mainOutputDir = '/store/user/%s/ele_reRECO/%s' % (os.environ['USER'], submitVersion)

#os.system('mkdir -p /eos/user/%s' % mainOutputDir)
#os.system('(git log -n 1;git diff) &> /eos/user/%s/git.log' % mainOutputDir)


#
# Common CRAB settings
#
from CRABClient.UserUtilities import config
config = config()

config.General.requestName             = ''
config.General.transferLogs            = False
config.General.workArea                = 'crab_%s' % submitVersion

config.JobType.pluginName              = 'Analysis'
config.JobType.psetName                = 'config_miniaod.py'
config.JobType.sendExternalFolder      = True
config.JobType.allowUndistributedCMSSW = True

config.Data.inputDataset               = ''
config.Data.inputDBS                   = 'global'
config.Data.publication                = False
config.Data.allowNonValidInputDataset  = True
config.Site.storageSite                = 'T2_TW_NCHC'

#
# Submit command
#
from CRABAPI.RawCommand import crabCommand
from CRABClient.ClientExceptions import ClientException
#from httplib import HTTPException

def submit(config, requestName, sample, extraParam=[]):
  config.General.requestName  = '%s' % (requestName)
  config.Data.inputDataset    = sample
  config.Data.outLFNDirBase   = '%s/' % (mainOutputDir)
  config.Data.splitting       = 'FileBased'
  config.Data.lumiMask        = None
  config.Data.unitsPerJob     = 1
  config.JobType.maxMemoryMB  = 4500
  #config.JobType.pyCfgParams  = defaultArgs + ['isMC=True' if isMC else 'isMC=False', 'era=%s' % era] + extraParam

  #print config
  try:                           crabCommand('submit', config = config, dryrun=False)
  #except HTTPException as hte:   print("Failed submitting task: %s" % (hte.headers))
  except ClientException as cle: print("Failed submitting task: %s" % (cle))

#
# Wrapping the submit command
# In case of doL1matching=True, vary the L1Threshold and use sub-json
#
from multiprocessing import Process
def submitWrapper(requestName, sample, extraParam=[]):
    p = Process(target=submit, args=(config, requestName, sample, extraParam))
    p.start()
    p.join()


#
# List of samples to submit, with eras
# Here the default data/MC for UL and rereco are given (taken based on the release environment)
# If you would switch to AOD, don't forget to add 'isAOD=True' to the defaultArgs!
#
#submitWrapper('DY', '/DYToLL_M-50_TuneCP5_14TeV-pythia8/Phase2Spring23DIGIRECOMiniAOD-PU200_L1TFix_Trk1GeV_131X_mcRun4_realistic_v9-v3/GEN-SIM-DIGI-RAW-MINIAOD')
#submitWrapper('TT', '/TT_TuneCP5_14TeV-powheg-pythia8/Phase2Spring23DIGIRECOMiniAOD-PU200_L1TFix_Trk1GeV_131X_mcRun4_realistic_v9-v1/GEN-SIM-DIGI-RAW-MINIAOD')
submitWrapper('DY_Trk1GeV', '/DYToLL_M-50_TuneCP5_14TeV-pythia8/Phase2Spring23DIGIRECOMiniAOD-PU200_Trk1GeV_131X_mcRun4_realistic_v5-v1/GEN-SIM-DIGI-RAW-MINIAOD')
submitWrapper('TT_Trk1GeV', '/TTToSemileptonic_TuneCP5_14TeV-powheg-pythia8/Phase2Spring23DIGIRECOMiniAOD-PU200_Trk1GeV_131X_mcRun4_realistic_v5-v1/GEN-SIM-DIGI-RAW-MINIAOD')

