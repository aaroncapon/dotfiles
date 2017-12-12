


//Format 1D histograms
//Just format colours
void format1Dhist(TH1* hist, Int_t colour, Int_t markerStyle = 21, Int_t markerSize = 1){
    hist->SetMarkerStyle(markerStyle);
    hist->SetMarkerColor(colour);
    hist->SetMarkerSize(markerSize);
    hist->SetLineColor(colour);
}
//Format colours, and add titles
void format1Dhist(TH1* hist, Int_t colour, TString xAxis, TString yAxis, Int_t markerStyle = 21, Int_t markerSize = 1){
    hist->SetMarkerStyle(markerStyle);
    hist->SetMarkerColor(colour);
    hist->SetMarkerSize(markerSize);
    hist->SetLineColor(colour);
    hist->GetYaxis()->SetTitle(yAxis);
    hist->GetXaxis()->SetTitle(xAxis);
}


//Function to format lower plot when taking ratios
void formatRatioPlot(TH1* hist, TString yAxis){

    hist->SetTitle("");

    hist->GetYaxis()->SetTitle(yAxis);
    hist->GetYaxis()->CenterTitle();
    hist->GetYaxis()->SetNdivisions(505);
    hist->GetYaxis()->SetTitleSize(20);
    hist->GetYaxis()->SetTitleFont(43);
    hist->GetYaxis()->SetTitleOffset(1.55);
    hist->GetYaxis()->SetLabelFont(43);
    hist->GetYaxis()->SetLabelSize(15);

    hist->GetXaxis()->SetTitleSize(20);
    hist->GetXaxis()->SetTitleFont(43);
    hist->GetXaxis()->SetTitleOffset(4.);
    hist->GetXaxis()->SetLabelFont(43);
    hist->GetXaxis()->SetLabelSize(15);

    return;
}

TH1F* calcDiElecRfactor(const TH1F* posHist, const TH1F* negHist, const TH1F* unlikeHist, Bool_t calcRfactor){

	//Clone used to make sure binning is identical.
	TH1F* rFactor = dynamic_cast<TH1F*>(unlikeHist->Clone("rFactor"));
	TH1F* denominator = dynamic_cast<TH1F*>(negHist->Clone("denominator"));

	//Dummy R factor
	if(calcRfactor == kFALSE){
		rFactor->Reset(); //clear contents.
		for(Int_t i = 1; i <= rFactor->GetNbinsX(); i++){
			rFactor->SetBinContent(i, 1);
			rFactor->SetBinError(i, 0.001);
		}
	}
	//Real R factor
	else{
		Float_t valuePos, valueNeg;
		Float_t errorPos, errorNeg;
		for(Int_t i = 0; i <= posHist->GetNbinsX(); i++){

			valuePos = posHist->GetBinContent(i);
			valueNeg = negHist->GetBinContent(i);

			errorPos = posHist->GetBinError(i);
			errorNeg = negHist->GetBinError(i);

			denominator->SetBinContent(i, 2*TMath::Sqrt(valuePos*valueNeg));
			denominator->SetBinError(i, TMath::Sqrt(errorPos) + TMath::Sqrt(errorNeg));
		}
		rFactor->Divide(denominator);
	}

	delete denominator;

  return rFactor;
}

//Calculate geomtric mean of like sign spectra for background calculation
TH1F* calcDiElecBackgr(const TH1F* posHist, const TH1F* negHist){

    //Use geometric mean of like signs to calculate background
    TH1F* backgr = dynamic_cast<TH1F*>(posHist->Clone("backgr"));
    backgr->Reset();

    Float_t valuePos, valueNeg;
    Float_t errorPos, errorNeg;
    for(Int_t i = 0; i <= posHist->GetNbinsX(); i++){

        valuePos = posHist->GetBinContent(i);
        valueNeg = negHist->GetBinContent(i);
        errorPos = posHist->GetBinError(i);
        errorNeg = negHist->GetBinError(i);
        backgr->SetBinContent(i, 2*TMath::Sqrt(valuePos*valueNeg));
        backgr->SetBinError(i, TMath::Sqrt(errorPos) + TMath::Sqrt(errorNeg));
    }
    return backgr;
}

TH1F* calcRawDiElecSpectrum(const TH1F* unlike, const TH1F* backgr, const TH1F* rFactor){

	TH1F* rawSpectrum = dynamic_cast<TH1F*>(unlike->Clone("rawSpectrum"));

	TH1F* correctedBackgr = dynamic_cast<TH1F*>(backgr->Clone("correctedBackgr"));
	correctedBackgr->Multiply(rFactor);

	rawSpectrum->Add(correctedBackgr, -1);

	return rawSpectrum;
}

TH1F* calcDiElecSpectrum(const TH1F* unlike, const TH1F* backgr, const TH1F* rFactor, TH1D* effCor = 0x0){

	Double_t intLuminosity = 1;

	//TODO: use vert. reconstruction and trigger efficiency

	TH1F* rawSpectrum = dynamic_cast<TH1F*>(unlike->Clone("rawSpectrum"));

	TH1F* correctedBackgr = dynamic_cast<TH1F*>(backgr->Clone("correctedBackgr"));
	correctedBackgr->Multiply(rFactor);

	rawSpectrum->Add(correctedBackgr, -1);

	if(effCor){
		Printf("Using efficiency correction!");
		rawSpectrum->Divide(effCor);
	}

	return rawSpectrum;
}

//Calculate significance, as per dielectron analysis definiton
TH1F* calcDiElecSignificance(const TH1F* signal, const TH1F* backgr){

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
        //Check if bins are empty. If so, assign dummy value
        if( (valueSignal == 0) && (valueBackgr == 0)){
            significance->SetBinContent(i, 0);
            significance->SetBinError(i, 0.000001);
        }
        else{
            preScaling = valueSignal/TMath::Sqrt(valueSignal + (2*valueBackgr));
            significance->SetBinContent(i, preScaling);


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

//Common TLatex objects
TLatex* getTexTitle(Float_t xPos, Float_t yPos){

    TLatex* tex = new TLatex(xPos, yPos, "ALICE Work in Progress");
    tex->SetNDC();
    tex->SetTextSize(0.04);
    tex->SetTextFont(42);

    return tex;
}
TLatex* getTexSystem(Float_t xPos, Float_t yPos, Bool_t isMC = kFALSE){

    TString description = "p-Pb, #sqrt{#it{s}_{NN}} = 5.02 TeV";
    if(isMC == kTRUE){
       description += ", DPMJET";
    }
    TLatex* tex = new TLatex(xPos, yPos, description);
    tex->SetNDC();
    tex->SetTextSize(0.03);
    tex->SetTextFont(42);

    return tex;
}
TLatex* getTexKinematics(Float_t xPos, Float_t yPos){

    TLatex* tex = new TLatex(xPos, yPos, "0.2 < p_{T} < 5 GeV/#it{c}, |#eta| < 0.8");
    tex->SetNDC();
    tex->SetTextSize(0.02);
    tex->SetTextFont(42);

    return tex;
}
//TODO
TLatex* getTexPairMom(Float_t xPos, Float_t yPos, Float_t textSize = 0.02, TString maxPt = 10.0, TString minPt = 0.0){

	TString mid = "p_{T}^{pair} < ";
	TString units = " GeV/#it{c}^{2}";
	TLatex* tex = 0x0;
	if(minPt = 0.0){
		TString pairPtDescription = mid + maxPt + units;
		tex = new TLatex(xPos, yPos, pairPtDescription);
	}
	else{
		TString pairPtDescription = minPt + " " + mid + maxPt + units;
		tex = new TLatex(xPos, yPos, pairPtDescription);
	}
	tex->SetNDC();
	tex->SetTextSize(textSize);
	tex->SetTextFont(42);

    return tex;
}
TLatex* getTexPairCuts(Float_t xPos, Float_t yPos){

    TLatex* tex = new TLatex(xPos, yPos, "#Phi_{V}^{pair} < #frac{3}{4}#pi for m_{ee} < 0.02 GeV/#it{c}^{2}");
    tex->SetNDC();
    tex->SetTextSize(0.02);
    tex->SetTextFont(42);

    return tex;
}
