;  list all layer in current cell

procedure(ListAllLayerInCell(libName cellName)

	lib = ddGetObj(libName)
	cell = dbOpenCellViewByType(libName cellName "layout" nil "r")
	
	fprintf(poport "In Cell %L \n" cell~>cellName )
	;listLHIC = cell~>layerHeaders~>layer
	;fprintf(poport "List layer %L\n" listLHIC )
	
	fprintf(poport "List purpose pair layer %L\n" cell~>layerPurposePairs~>layerName)
	fprintf(poport "List purpose pair layer num %L\n" cell~>layerPurposePairs~>layerNum)
	dbClose(cell)

)


; Testcase
ListAllLayerInCell("LIBNAME" "CELLNAME")
