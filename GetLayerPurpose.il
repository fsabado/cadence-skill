printf("\n New Function: FGIsLPPUsed ( lpp ) " )
printf("\n  Check if layer-pupose is used in current cellview")

procedure(FGIsLPPUsed(lpp)
  prog(list(cv)
    cv=geGetWindowCellView()
    foreach(cvlpp cv~>lpps
      if((cvlpp~>layerName == car(lpp) && cvlpp~>purpose == cadr(lpp)) then
return(t))
    )
    return(nil)
  )
)


printf("\n New Function: ListLayerOfCell() " )
printf("\n List all the layers in current cellview" )
procedure(ListLayerOfCell()
  prog(list(cv)
counter_Layer = 0
    cv=geGetWindowCellView()
    foreach(cvlpp cv~>lpps
counter_Layer = counter_Layer + 1
NameOfLayer = (cvlpp~>layerName)
PurposeOfLayer = (cvlpp~>purpose)
layerNumOfLayer = (cvlpp~>layerNum)
printf("\n %n Name:%s Purpose: %s CADLayNumber %n" counter_Layer NameOfLayer PurposeOfLayer layerNumOfLayer )
;printf("\n Cadence Layer number %n " layerNumOfLayer )
;printf("\n Is name is %s" NameOfLayer)
;printf("\n Is purpose is  %s" PurposeOfLayer)
);foreach
printf("\n In %s there is %n layers." (cv~>cellName) counter_Layer)
);prog
);procedure
