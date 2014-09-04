/*
;Automatically generate pwell on top cell view based on nwell present in lower levels
Author: Christophe Guerrier
Date: 2013

Description: Automatically generate pwell on top cell view based on nwell present in lower levels

Argument: cell view id, like obtained by dbOpenCellViewByType

*/


;procedure needed to bring lower level shapes back to the top.
procedure(reduceList(shape)
	if(listp(shape) then
	     reduceList(cadr(shape))
  	else
      		shape
  )
)


procedure(GeneratePWELL_LAYERELL_From_NWELL_LAYERELL(cv)
; First gets all the nwell shapes, for all levels
shapeList = dbGetOverlaps(cv cv~>bBox list("NWELL_LAYER" "drawing") 99)
; copied shapes will be stored here.
newshapeList = list()

;Note for myself, if not using mapcar won't work ... why ???
foreach(mapcar Shape shapeList
	srcShape = reduceList(Shape)
	;copy each shapes to the top cellview
	copied_shape = dbCopyFig(srcShape cv dbGetHierPathTransform(Shape))
	;dbCopyFig(srcShape cv list(0:0 "R90" 2.0))
	append1(newshapeList copied_shape)
)

;merge - in 2 steps
leMergeShapes(newshapeList)
;This will merge with preexisting nwell at level 0 ( might not be wanted )
shapeListlvl0 = dbGetOverlaps(cv cv~>bBox list("NWELL_LAYER" "drawing") 0)
leMergeShapes(shapeListlvl0)

shapeListlvl0 = dbGetOverlaps(cv cv~>bBox list("NWELL_LAYER" "drawing") 0)

;generate pwell
;somehow need first to create an overlapping layer whihc will be deleted after.
AllPwell =dbCreateRect(cv list("PWELL_LAYER" "drawing") cv~>bBox)
dbLayerAndNot(cv list("PWELL_LAYER" "drawing") list(AllPwell) shapeListlvl0)
dbDeleteObject(AllPwell)
)

/* TESTING - how to use
libName = "LIB NAME"
cellName = "CellName"
cv = dbOpenCellViewByType(libName cellName "layout" nil "a")
GeneratePWELL_LAYERELL_From_NWELL_LAYERELL(cv)
dbSave(cv)
dbClose(cv)
*/
