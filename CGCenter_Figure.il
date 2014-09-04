; Move Orgin of cell to 0,0 and make it center
; Christophe Guerrier
; April 18, 2005
procedure(CGCenter_Figure()

let((cv ll ur llx lly urx ury)

cv = geGetWindowCellView()
;; In this first version need to draw a recatngle ( boundary ) to get the maxmin coord
;;rectangle = geGetSelSet()
;;point_ll = lowerLeft(car(rectangle~>bBox))
;;point_ur = upperRight(car(rectangle~>bBox))


;; Get Max/minimum coordinates

; Get lowerleft point of CellView
point_ll = lowerLeft(cv~>bBox)
; Get upperight point of CellView
point_ur = upperRight(cv~>bBox)
llx = xCoord(point_ll)
lly = yCoord(point_ll)
urx = xCoord(point_ur)
ury = yCoord(point_ur)


;; Calculate center
center_x = (llx+urx)/2
center_y = (lly+ury)/2

printf("\nX center was  %n" center_x)
printf("\nY center was  %n" center_y)

;; PB if the results is off grid 

;; Get the tech file
tf=techGetTechFile(cv)
;; Get grid resolution
GridRes1=techGetMfgGridResolution(tf)
printf("\nResolution grid is %n" GridRes1)


real_y1=(center_y/GridRes1)
real_x1=(center_x/GridRes1)
rounded_y1=round(center_y/GridRes1)
rounded_x1=round(center_x/GridRes1)
y1=real_y1-rounded_y1
x1=real_x1-rounded_x1

if( x1 != 0 || y1 != 0
then
printf("\nWarning") 
printf("\nResult off grid I do nothing") 
;;leMoveCellViewOrigin(cv center_x:center_y)

;; TEST if result is off grid
;; TEST if result is off grid

;; Test if already center
else
if( center_x != 0
	then
printf("\nMoving Origin ")
leMoveCellViewOrigin(cv center_x:center_y)
else
( if center_y != 0 then
printf("\nMoving Origin ")
leMoveCellViewOrigin(cv center_x:center_y)
else
printf("\nArlready Centered... nothing to do")
);if test centerx different from 0
);if test centery different from 0

);if test grid

) ; let

) ; procedure

procedure(CGPUTQADRANTPOS()

; This procedure put the figure in the positive quadrant
; X>0 Y>0 origin 0.0

let((cv ll ur llx lly urx ury)

cv = geGetWindowCellView()
;; In this first version need to draw a recatngle ( boundary ) to get the maxmin coord
;;rectangle = geGetSelSet()
;;point_ll = lowerLeft(car(rectangle~>bBox))
;;point_ur = upperRight(car(rectangle~>bBox))


;; Get Max/minimum coordinates

; Get lowerleft point of CellView
point_ll = lowerLeft(cv~>bBox)
; Get upperight point of CellView
point_ur = upperRight(cv~>bBox)
llx = xCoord(point_ll)
lly = yCoord(point_ll)
urx = xCoord(point_ur)
ury = yCoord(point_ur)


;; Calculate center
;;center_x = (llx+urx)/2
;;center_y = (lly+ury)/2
; Here only the minimum coordinates are used.

;;leMoveCellViewOrigin(cv center_x:center_y)

;; Test if already center

if( llx != 0
	then
printf("\nMoving Origin ")
leMoveCellViewOrigin(cv llx:lly)
else
( if center_y != 0 then
printf("\nMoving Origin ")
leMoveCellViewOrigin(cv llx:lly)
else
printf("\nArlready ... nothing to do")
))



) ; let

) ; procedure



