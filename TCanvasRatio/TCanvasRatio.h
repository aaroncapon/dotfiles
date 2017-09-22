
#ifndef TCANVASRATIO_H
#define TCANVASRATIO_H

#include "TCanvas.h"
#include "TPad.h"
#include "TGaxis.h"
#include "TH1.h"

class TCanvasRatio: public TObject{

    private:
        
        TCanvas* canvas;

        TPad* pad1;
        TPad* pad2;

        TGaxis* axis;

        TH1* fRatioPlot;


    public:
        
        TCanvasRatio(TString canvasName, TH1* plot1, TH1* plot2);
        ~TCanvasRatio();

        void cdPad1();
        void cdPad2();

        void setRatioXtitle(TString title);
        void setRatioYtitle(TString title);

        ClassDef(TCanvasRatio, 1);

        

};
