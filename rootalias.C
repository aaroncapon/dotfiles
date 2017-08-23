


//Format 1D histograms
//Just format colours
void setup1Dhist(TH1* hist, Int_t colour){
    hist->SetMarkerStyle(21);
    hist->SetMarkerColor(colour);
    hist->SetLineColor(colour);
}
//Format colours, and add titles
void setup1Dhist(TH1* hist, Int_t colour, TString xAxis, TString yAxis){
    hist->SetMarkerStyle(21);
    hist->SetMarkerColor(colour);
    hist->SetLineColor(colour);
    hist->GetYaxis()->SetTitle(yAxis);
    hist->GetXaxis()->SetTitle(xAxis);
}

//Useable colours
//I.e. darker and can be used in presentations
Int_t kGREEN = kGreen + 2; 
Int_t kCYAN = kCyan + 2;
Int_t kMAGENTA = kMagenta + 2;
Int_t kORANGE = kOrange + 7;

//Enforce ALICE formatting
void SetStyle() {
    //gStyle->Reset("Plain");
    gStyle->SetOptTitle(1);
    gStyle->SetOptStat(0);
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

    std::cout << "ALICE style set!" << std::endl;


}



//Calculate significance, as per dielectron analysis definiton
TH1F* calcSignificance(const TH1F* signal, const TH1F* backgr){

    TH1F* significance = dynamic_cast<TH1F*>(signal->Clone("significance"));
    
    Float_t errorSignal, errorBackgr;
    Float_t valueSignal, valueBackgr;
    Float_t binWidth;
    Float_t preScaling;
    Float_t finalError;

    for(Int_t i = 1; i <= significance->GetNbinsX(); i++){

        //Get S and B values
        valueSignal = signal->GetBinContent(i);
        valueBackgr = backgr->GetBinContent(i);
        errorSignal = signal->GetBinError(i);
        errorBackgr = backgr->GetBinError(i);
        binWidth = significance->GetBinWidth(i);

        //Find significance
        if( (valueSignal == 0) && (valueBackgr == 0)){
            significance->SetBinContent(i, 0);
            significance->SetBinError(i, 0.000001);
        }
        else{
            preScaling = valueSignal/TMath::Sqrt(valueSignal + (2*valueBackgr));
            significance->SetBinContent(i, preScaling/TMath::Sqrt(binWidth));
            //significance->SetBinContent(i, preScaling);


            finalError = 0.5*(TMath::Sqrt((errorSignal*errorSignal) + (16*errorBackgr*errorSignal) - 16*(errorBackgr*errorBackgr))/(errorSignal+(2*errorBackgr)));
            if(finalError != 0){
                significance->SetBinError(i, finalError);
            }else{
                significance->SetBinError(i, 0);
            }
        }
            //std::cout << "Sig: "       << valueSignal << ", backgr: " << valueBackgr << std::endl;
            //std::cout << "Bin width: " << binWidth << ", Bin " << i << " value: " << preScaling/TMath::Sqrt(binWidth) << std::endl;
    }

    
    return significance;
}
