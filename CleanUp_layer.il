/*
Description: Cleanup given layer in one given cell
Use with caution
Author: Christophe Guerrier
Date: 2013


*/




procedure( delLayer( libName )
  let( ((count 0) lib cv)
    ;; count = 0 ;; no longer needed, initialised in let statement
    lib = ddGetObj( libName)
   
        foreach( cell lib~>cells

            when( setof( the_view cell~>views the_view~>name == "layout")
           
            cv = dbOpenCellViewByType( libName cell~>name "layout")
           
            foreach( shape car(setof(x cv~>lpps x~>layerName == "xxxxxxxxxx"))~>shapes

               dbDeleteObject(shape)

                count++ 

            ); foreach shape
                   
            dbClose( cv )

        );when setof

      );foreach cell

    count ;; return the number removed

  ); let 

);procedure




procedure(CleanUpLayer(cv layername)
	let(((count 0))	
            foreach( shape car(setof(x cv~>lpps x~>layerName == layername))~>shapes
               dbDeleteObject(shape)
		count++
		)
	count
	) ;let
	dbSave(cv)
	dbClose(cv)
)


procedure(RecursiveFromTopCellCleanUp(libName TopCellName)
	cvId = dbOpenCellViewByType(libName TopCellName "layout" nil "a")
	fprintf(poport "Processing ...%L\n" TopCellName )
	CleanUpLayer(cvId "ex_R_rule")
	
	foreach(inst cvId~>instances
		if(inst~>libName == libName then
			RecursiveFromTopCellCleanUp(libName inst~>cellName)
		)	
	)
)




