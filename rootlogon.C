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
    gStyle->SetPalette(kBird);


    //Load array containing used run numbers (LHC16q)
    TString LHC16qRuns[] = {"265309/", "265332/", "265334/", "265335/", "265336/", "265338/", 
                            "265339/", "265342/", "265343/", "265344/", "265377/", "265378/", 
                            "265381/", "265383/", "265384/", "265385/", "265387/", "265388/", 
                            "265419/", "265420/", "265421/", "265422/", "265424/", 
                            /*"265425/", "265426/",*/ //Runs left out after bad QA
                            "265427/", "265435/", "265499/", "265500/", "265501/", 
                            "265521/", "265525/"};

	Double_t spectraBins16q[] = {0.00, 0.025, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.12, 0.2, 0.3, 0.4, 
                                0.5, 0.6, 0.7, 0.8, 0.95, 1.05, 1.25, 1.5, 1.75, 2.0, 2.25, 
                                2.5, 2.75, 2.9, 3.0, 3.05, 3.1, 3.3, 3.8, 5.00};

    std::cout << std::endl;


}
