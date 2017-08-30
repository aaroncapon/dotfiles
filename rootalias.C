


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
