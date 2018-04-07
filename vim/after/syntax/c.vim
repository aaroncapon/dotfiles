"Vim syntax file
"Langauge: ROOT in C/C++
"Maintainer: Yo mumma


if !exists("c_no_cern_root")
   syn keyword	cType		    TH1 TH1C TH1D TH1F TH1I TH1K TH1S 
   syn keyword	cType		    TH2 TH2C TH2D TH2F TH2I TH2S
   syn keyword	cType		    TH3 TH3C TH3D TH3F TH3I TH3S
   syn keyword	cType		    TF1 TF2 TF3
   syn keyword	cType		    TBranch TStopwatch TNamed
   syn keyword	cType		    THStack TGraph TGraph2D TCanvas TRandom TLimit TLatex
   syn keyword	cType		    TNtuple TObject TTree TIter TKey TRandom2 TShape TPad TMacro
   syn keyword	cType       TString TLine TLegend TFile TDatime TRandom3 TMath
   syn keyword	cType       TLeaf TLeafB TLeafC TLeafD TLeafElement TLeafF TLeafI TLeafL TLeafO TLeafObject
   syn keyword	cType       TChain TDirectory TList TArc TBox TEllipse TPolyLine TCurlyLine TCurlyArc TEllipse
   syn keyword	cType       TMinuit TFitter TLinearFitter TLorentzVector TLorentzRotation TVector3 TVector2
   syn keyword	cType       TRotation TGenPhaseSpace TFeldmanCousins TRobustEstimator TRolke TQuaternion
   syn keyword	cType       TPostScript TSVG TPDF TImageDump THtml TColor TStyle TComplex TPRegexp
   syn keyword	cType       TObjArrayIter TMapIter TClass TEnv TGlobal TCint TROOT TDictionary TTime TTimer
   syn keyword  cType       TParticle TBits
   syn keyword	cType       Double_t Int_t Float_t Long_t Bool_t Byte_t
   syn keyword	cType      	char_t Marker_t Double32_t Float16_t Long64_t
   syn keyword	cType       Short_t Stat_t Style_t Text_t UShort_t Option_t
   syn keyword  cBoolean    kTRUE kFALSE
"Additionally added ROOT classes
   syn keyword  cType       TTreeStream TAxis TGaxis TEfficiency TObjArray TRatioPlot 
   syn keyword  cType       TParticlePDG TDatabasePDG TPaveStats
   syn keyword  cType       Char_t UChar_t UInt_t ULong_t Ulong_t
"AliPhysics classes
   syn keyword  cType       AliVEventHandler AliVEvent AliVTrack AliVVertex AliVParticle
   syn keyword	cType				AliESDEvent AliESDtrack AliESDVertex AliESDtrackCuts 
   syn keyword  cType       AliAODEvent AliAODTrack AliAODVertex AliMultSelectionTask
   syn keyword  cType       AliESDv0
   syn keyword  cType       AliAnalysisTask
   syn keyword  cType       AliInputEventHandler AliAnalysisManager AliAnalysisGrid AliAnalysisAlien 
   syn keyword  cType       AliAnalysisDataContainer AliAnalysisTaskSE AliAnalysisCuts
   syn keyword	cType	      AliMCEventHandler AliMCEvent AliMCParticle AliAODMCParticle
   syn keyword  cType       AliMultSelection AliPID AliPIDResponse AliGenCocktailEventHeader
   syn keyword  cType       AliAnalysisTaskSimpleTreeMaker AliAnalysisTaskMLTreeMaker
"Dielectron classes
   syn keyword  cType       AliDielectron AliDielectronHistos AliAnalysisTaskMultiDielectron
   syn keyword  cType       AliDielectronCutGroup AliDielectronVarCuts AliDielectronMixingHandler
   syn keyword  cType       AliDielectronPID AliDielectronTrackCuts AliDielectronVarManager AliDielectronEvenCuts
   syn keyword  cType       AliDielectronTrackRotator LMEECutLib AliDielectronSignalMC 
   syn keyword  cType       AliAnalysisFilter AliAnalysisTaskElectronEfficiency AliDielectronEventCuts
   syn keyword  cType       ESource EBranchRelation EJpsiRadiativ 

   syn keyword	cConstant   kRed kPink kBlue kMagenta kViolet kAzure kCyan kTeal kGreen 
	 syn keyword  cConstant   kOrange kSpring kYellow kGray kBlack kWhite
"Custom colours
   syn keyword	cConstant   kGREEN kMAGENTA kCYAN kORANGE
endif
