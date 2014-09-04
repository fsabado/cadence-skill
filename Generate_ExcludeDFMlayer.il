/*
Description: Generate an exclude Layer  over given std cell everzwhere they are instantiated.
; Input: top level cell
; procedure will do down the hierarchy
; only cells affected are the one of the current library

Author: Christophe Guerrier
Date: 2013


*/


/* Steps
1. explore each sub cell
2. in each cell looks for prBoundary layer (down 1 level )
3. if layer belongs to a standard cell, copy to the top and transform to an exclude layer
*/
procedure(reduceList(shape)
	if(listp(shape) then
	     reduceList(cadr(shape))
  	else
      		shape
  )
)


procedure(GenerateLayerFromInstances(cv layer2detect layer2add std_cell_library)
	;Does not work for prBoundary, but works for any other drawing layer of type rect/polygon - powerful
	;prBoundary is detected as a label
	;limit to one level below in the hierarchy
	l2dshp1 = dbGetOverlaps(cv cv~>bBox layer2detect 1)

	;Only consider the object coming from instance - there will appear a list from dbGetOverlaps
	l2dshp1_islist = setof(localshp l2dshp1 listp(localshp))
	;l2dshp1_inst = setof(localshp l2dshp1_islist or(car(localshp~>objType)=="inst" car(localshp~>objType == "mosaic") ))

	;reduce it to instance coming from std cell lib
	l2dshp1_stdcell = setof(localshp l2dshp1_islist member(car(localshp~>libName) std_cell_library))
	;DEBUG fprintf(poport "Debug ...%L\n" l2dshp1_stdcell~>??)	

	; need to be copied to top level first
	foreach(mapcar srcShape 	l2dshp1_stdcell
		;DEBUG fprintf(poport "Copying ...%L\n" reduceList(srcShape)~>layerName)
		copied_boundary = dbCopyFig(reduceList(srcShape) cv dbGetHierPathTransform(srcShape))
		;DEBUG fprintf(poport "Copied ...%L\n" copied_boundary~>layerName)
		copied_boundary->lpp=layer2add
		;exclude = dbLayerOr(cv car(layer2add) list(copied_boundary))
		;fprintf(poport "LayerOr ...%L\n" exclude~>layerName)
		;DEBUG fprintf(poport "Layer ...%L\n" car(layer2add))
		;dbDeleteObject(copied_boundary)
		)

	)
	
procedure(GenerateLayerFromInstanceBoundary(cv layer2addlist std_cell_library)
	;only consider instances belonging to std cell
	instances_list =setof(inst cv~>instances member(inst~>master~>libName std_cell_library))
	foreach(inst instances_list
		;draw bbx
		foreach(layer2add layer2addlist
			excludemask = dbCreateRect(cv layer2add inst~>bBox)
		)
	)
)

	
procedure(GenerateExcludeDFMlayer(cv)
	useBoundary = 1

	;wrapper for the more generic function
	std_cell_library = list("library_name_stdcell" "library_name_stdcell2")
	;Only first element is used.
	layer2detect = list("prBoundary" "boundary")
	;layer2detect = list("M1" "drawing")
	;need to verify if guideline or recommended is the one we want ! Ony first element of the list is used
	layer2add = list("ex_R_rule" "require")
	layer2addlist = list(list("ex_R_rule" "require") list("ex_R_rule" "recommend") list("ex_R_rule" "guideline") list("ex_R_rule" "analog"))
	;layer2addlist = list(list("ex_R_rule" "guideline") list("ex_R_rule" "analog"))

	;Call the function:
	if(useBoundary then
		GenerateLayerFromInstanceBoundary(cv layer2addlist std_cell_library)
	else
		GenerateLayerFromInstances(cv layer2detect layer2add std_cell_library)
	)
	
	dbSave(cv)
	dbClose(cv)
)
			
;Usage Example
;Working Library Name
;libName = "Your working library name"
;CellName = "cg_testing"
;cv = dbOpenCellViewByType(libName TopCellName "layout" nil "a")
;GenerateExcludeDFMlayer(cv)


procedure(RecursiveFromTopCellGenerateExcludeDFM(libName TopCellName)
	cvId = dbOpenCellViewByType(libName TopCellName "layout" nil "a")
	fprintf(poport "Processing ...%L\n" TopCellName )
	GenerateExcludeDFMlayer(cvId)
	
	foreach(inst cvId~>instances
		if(inst~>libName == libName then
			RecursiveFromTopCellGenerateExcludeDFM(libName inst~>cellName)
		)	
	)
)




