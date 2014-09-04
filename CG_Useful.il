procedure(CGZoomBox(llx lly urx ury)
;hiZoomIn(hiGetCurrentWindow() list(0:0 10:10))
hiZoomIn(hiGetCurrentWindow() list(llx:lly urx:ury))
)

procedure(CGGoTo(coox cooy)
leZoomToPoint(hiGetCurrentWindow(), coox:cooy)
)

procedure(CGZoomTo(coox cooy)
llx = coox - 2
lly = cooy - 2
urx = coox + 2
ury = cooy + 2
hiZoomIn(hiGetCurrentWindow() list(llx:lly urx:ury))
)

procedure(CGZ(coox cooy)
llx = coox - 2
lly = cooy - 2
urx = coox + 2
ury = cooy + 2
hiZoomIn(hiGetCurrentWindow() list(llx:lly urx:ury))
)

