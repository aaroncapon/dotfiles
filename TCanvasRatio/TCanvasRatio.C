
#include "TCanvasRatio.h"

ClassImp(TCanvasRatio)


TCanvasRatio::TCanvasRatio(TString canvasName, TH1* plot1, TH1* plot2){

    fRatioPlot = dynamic_cast<TH1*>(plot1->Clone(canvasName+"ratio"));
    fRatioPlot->Divide(plot2);
    fRatioPlot->GetYaxis()->SetTitle("ratio");

    canvas = new TCanvas(canvasName, canvasName);
    canvas->SetWindowSize(900, 900);
    canvas->SetCanvasSize(900, 900);
    
    pad1 = new TPad(canvasName+"pad1", canvasName+"pad1", 0, 0.3, 1, 1.0);
    pad1->SetBottomMargin(0);
    pad1->SetGridx();
    pad1->Draw();

    axis = new TGaxis(-5, 20, -5, 220, 20, 220, 510, "");
    axis->SetLabelFont(43);
    axis->SetLabelSize(15);
    axis->cd();

    canvas->cd();
    
    pad2 = new TPad(canvasName+"pad2", canvasName+"pad2", 0, 0.05, 1, 0.3);
    pad2->SetTopMargin(0);
    pad2->Draw();
    fRatioPlot->Draw();
    
}


void TCanvasRatio::cdPad1(){

    pad1->cd();
}


void TCanvasRatio::cdPad2(){

    pad2->cd();
}


void TCanvasRatio::setRatioXtitle(TString title){

    fRatioPlot->GetXaxis()->SetTitle(title);
    return;
}

void TCanvasRatio::setRatioYtitle(TString title){

    fRatioPlot->GetYaxis()->SetTitle(title);
    return;
}
