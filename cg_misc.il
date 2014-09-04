;Misc procedures
;Christophe Guerrier
; Cadence Virtuoso
println "Functions defined:"
println " - ListAllLayers()"

;-----------------------------------------------------------------------------
procedure(ListAllLayers(@optional (cv deGetCellView()))
	let( (list_layer)
		list_layer = cv~>shapes~>lpp
		foreachs( lna list_layer println(car(lna)) )
	);let
) ;procedure

;-----------------------------------------------------------------------------
procedure(GetTechInfo(@optional (cv deGetCellView()))
	let((libName tfId rules myRule layerName listlayer)
	;get libName
	libName = cv1~>libName	
	;technology file ID
	tfId = techGetTechFile(ddGetObj(libName))
	rules = techGetSpacingRules(tfid)
	)
)
;-----------------------------------------------------------------------------





