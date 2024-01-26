#!/bin/bash

EVENTS=3

#CUSTOMIZE="\
#process.RECOSIMoutput.outputCommands.append('keep *_*_*_HLT'); \
#process.RECOSIMoutput.outputCommands.append('keep *_*_*_SIM'); \
#process.RECOSIMoutput.outputCommands.extend(process.L1TriggerFEVTDEBUG.outputCommands); \
#process.RECOSIMoutput.outputCommands.extend(process.MicroEventContentMC.outputCommands); \
#process.load('HLTrigger.Configuration.HLTPhase2TDR_EventContent_cff'); \
#process.RECOSIMoutput.outputCommands.extend(process.HLTPhase2TDR.outputCommands); \
#"

#CUSTOMIZE="\
#process.load('RecoMTD.Configuration.RecoMTD_EventContent_cff'); \
#process.MINIAODSIMoutput.outputCommands.extend(process.RecoMTDRECO.outputCommands); \
#"

#CUSTOMIZE="\
#process.MINIAODSIMoutput.outputCommands.append('keep recoGsfElectron*_gedGsfElectron*_*_*'); \
#process.MINIAODSIMoutput.outputCommands.append('keep recoGsfTracks_electronGsfTracks_*_*'); \
#process.MINIAODSIMoutput.outputCommands.append('keep recoPhoton*_gedPhoton*_*_*'); \
#process.MINIAODSIMoutput.outputCommands.append('keep recoSuperClusters_particleFlowSuperCluster*_*_*'); \
#process.MINIAODSIMoutput.outputCommands.append('keep recoSuperClusters_*_*_*'); \
#process.MINIAODSIMoutput.outputCommands.append('keep recoTracks_trackExtenderWithMTD_*_*'); \
#"

CUSTOMIZE="\
process.MINIAODSIMoutput.outputCommands.append('keep recoGsfElectron*_gedGsfElectron*_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep recoGsfTracks_electronGsfTracks_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep recoPhoton*_gedPhoton*_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep *_ecalDrivenGsfElectronsHGC_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep *_ecalDrivenGsfElectronCoresHGC_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep *_photonsHGC_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep *_photonCoreHGC_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep recoSuperClusters_particleFlowSuperCluster*_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep recoSuperClusters_*_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep recoTracks_generalTracks_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep recoTracks_trackExtenderWithMTD_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep *_tofPID_*_*') \n\
process.MINIAODSIMoutput.outputCommands.append('keep *_mtdTrackQualityMVA_*_*') \n\
"

# cmsDriver command
cmsDriver.py  \
--python_filename \
    config_miniaod.py \
--processName=reRECO \
--eventcontent \
    MINIAODSIM \
--customise \
    SLHCUpgradeSimulations/Configuration/aging.customise_aging_1000 \
--datatier \
    MINIAODSIM \
--inputCommands \
    "keep *, drop *_*_*_RECO" \
--fileout \
    file:output_miniaod.root \
--conditions \
    auto:phase2_realistic_T21 \
--customise_commands \
    "$CUSTOMIZE" \
--step \
    RAW2DIGI,RECO,RECOSIM,PAT \
--geometry \
    Extended2026D95 \
--nStreams \
    3 \
--filein \
    "/TTToSemileptonic_TuneCP5_14TeV-powheg-pythia8/Phase2Spring23DIGIRECOMiniAOD-PU200_Trk1GeV_131X_mcRun4_realistic_v5-v1/GEN-SIM-DIGI-RAW-MINIAOD" \
--era \
    Phase2C17I13M9 \
--runUnscheduled \
--no_exec \
--mc \
-n $EVENTS

