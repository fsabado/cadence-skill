;Delete all steiners objects
procedure(DELSTEINER()
  prog(list(cv)
  cv=geGetWindowCellView()
  foreach(sh cv~>steiners
     dbDeleteObject(sh)
  )
))



/* USAGE:
This SKILL code dumps following information about a given cellview:
1. Cellview BBox
2. BBox of all instances
3. BBox of all the vias
4. point list of prBoundary
5. Point list of all markers in cellview
6. BBox of all steiners in cellview
7. BBox and layer purpose information of all shapes
8. BBox of all the blockages in cellview
This information can help in finding the reason of a big bounding box of cv.
Load the code in CIW;
load "DumpAllShapes.il"
Open the concerned cellview and then type below in CIW: 
DumpAllShapes("shplist.txt")

The information will be dumped to the given file i.e. shplist.txt

*/


procedure(DumpAllShapes(file @optional (cv geGetEditCellView()))
let((op)
op=outfile(file)
printf("Shape dumped\n")
fprintf(op " LIBRARY:%s\t CELL:%s\t VIEW:%s\t\n" cv~>libName cv~>cellName cv~>viewName)
fprintf(op "Cellview BBOX: %L\n" cv~>bBox)
fprintf(op "\n")
foreach(inst cv~>instances 
 fprintf(op "Instance %L with BBOX %L\n" inst~>name inst~>bBox)
 )
fprintf(op "\n")
foreach(via cv~>vias 
 fprintf(op "Via %L with BBOX %L\n" via~>viaHeader~>viaDefName via~>bBox)
 )
fprintf(op "\n")
fprintf(op "Cellview prBoundary: %L\n" cv~>prBoundary~>points)
fprintf(op "\n")
fprintf(op "Markers in cellview: %L\n" cv~>markers~>points)
fprintf(op "\n")
fprintf(op "Steiners in cellview: %L\n" cv~>steiners~>bBox)
fprintf(op "\n")
fprintf(op "Blockages in cellview: %L\n" cv~>blockages~>bBox)
fprintf(op "\n")
foreach(sh cv~>shapes 
                fprintf(op "Shape on layer %L  purpose %L at location %L\n" sh~>layerName sh~>purpose sh~>bBox)
                )
fprintf(op "# END #\n")
close(op)
))


