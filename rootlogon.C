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

    std::cout << std::endl;


}
