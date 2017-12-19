//Root logon script
{
	std::cout << "New ROOT session." << std::endl;

	std::cout << "ALICE style plotting set." << std::endl;

	gStyle->SetOptTitle(1);
	//gStyle->SetOptStat(0);
	gStyle->SetPalette(56); //54
	gStyle->SetCanvasColor(10);
	gStyle->SetCanvasBorderMode(0);
	gStyle->SetFrameLineWidth(1);
	gStyle->SetFrameFillColor(kWhite);
	gStyle->SetPadColor(10);
	gStyle->SetPadTickX(1);
	gStyle->SetPadTickY(1);
	gStyle->SetPadBottomMargin(0.15);
	gStyle->SetPadLeftMargin(0.15);
	gStyle->SetHistLineWidth(1);
	gStyle->SetHistLineColor(kRed);
	gStyle->SetFuncWidth(2);
	gStyle->SetFuncColor(kGreen);
	gStyle->SetLineWidth(2);
	gStyle->SetLabelSize(0.045,"xyz");
	gStyle->SetLabelOffset(0.01,"y");
	gStyle->SetLabelOffset(0.01,"x");
	gStyle->SetLabelColor(kBlack,"xyz");
	gStyle->SetTitleSize(0.05,"xyz");
	gStyle->SetTitleOffset(1.4,"y");
	gStyle->SetTitleOffset(1.2,"x");
	gStyle->SetTitleFillColor(kWhite);
	gStyle->SetTextSizePixels(26);
	gStyle->SetTextFont(42);
	//  gStyle->SetTickLength(0.04,"X");  gStyle->SetTickLength(0.04,"Y"); 

	gStyle->SetLegendBorderSize(0);
	gStyle->SetLegendFillColor(kWhite);
	//  gStyle->SetFillColor(kWhite);
	gStyle->SetLegendFont(42);


	//Automatically create weights object for histograms
	std::cout << "Sumw2 objects automatically created." << std::endl;
	TH1::SetDefaultSumw2();

	//Do not add histograms by name to TDirectory
	//std::cout << "Histograms not added to Tdirectory list" << std::endl;
	//TH1::AddDirectory(kFALSE);

	//Useable colours
	//I.e. darker and can be used in presentations
	Int_t kGREEN = kGreen + 2; 
	Int_t kCYAN = kCyan + 2;
	Int_t kMAGENTA = kMagenta + 2;
	Int_t kORANGE = kOrange + 7;
	std::cout << "Custom capitilised colours loaded." << std::endl;

  //Force kBird(blue/yellow) palette
	//Check if using AliPhysics which doesn't support anything
	#if ROOT_VERSION_CODE >= ROOT_VERSION(6,00,0)
		gStyle->SetPalette(kBird);
	#endif


	//Run and spectrum arrays
	//Load array containing used run numbers (LHC16q)
	//"265425/", "265426/", Runs left out after bad QA
	TString LHC16qRuns[] = {"265309/", "265332/", "265334/", "265335/", "265336/", 
													"265338/", "265339/", "265342/", "265343/", "265344/",
													"265377/", "265378/", "265381/", "265383/", "265384/",
													"265385/", "265387/", "265388/", "265419/", "265420/",
													"265421/", "265422/", "265424/", "265427/", "265435/", 
													"265499/", "265500/", "265501/", "265521/", "265525/"};


	//Runs in vectors
	std::vector<TString> runs16q = {"265309/", "265332/", "265334/", "265335/", "265336/",
																  "265338/", "265339/", "265342/", "265343/", "265344/",
																  "265377/", "265378/", "265381/", "265383/", "265384/",
																  "265385/", "265387/", "265388/", "265419/", "265420/",
																  "265421/", "265422/", "265424/", "265427/", "265435/",
																  "265499/", "265500/", "265501/", "265521/", "265525/"};

  //LHC17f2b runs (cent and cent_woSDD missing run 15)
	std::vector<TString> runs17f2b = {"01/", "02/", "03/", "04/", "05/",
																	  "06/", "07/", "08/", "09/", "10/",
																	  "11/", "12/", "13/", "14/", "15/"};
 //Pt bins
	const Double_t ptBins16q[] = {0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.60, 0.65,
										              0.70, 0.75, 0.80, 0.85, 0.90, 1.00, 1.10, 1.15, 1.25, 1.35,
										              1.55, 1.80, 2.05, 2.30, 2.60, 2.90, 3.30, 3.60, 4.00, 5.00};
											            //, 6.50, 8.00, 10.0};
	
//Mass bins
	const Double_t spectraBins16q[] = {0.00, 0.025, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.20,
															         0.30, 0.400, 0.50, 0.60, 0.70, 0.80, 0.95, 1.05, 1.25, 1.50,
															         1.75, 2.000, 2.25, 2.50, 2.75, 2.90, 3.00, 3.05, 3.10, 3.30,
															         3.8, 5.00};
    std::cout << std::endl;


}
