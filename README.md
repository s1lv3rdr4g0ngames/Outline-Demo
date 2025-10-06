The steps of this process:
	
Main camera renders every layer
Every object is on layer 1 and 2
If you want an object outlined, it gets the OutlIneDefiner material as a next pass
The OutlineDefiner says that if the visible layer is layer 2, 
	then make the thing red (and unshaded), 
	otherwise make it invisible.
The RemoteTransform tells the camera in the subviewport to match the main camera
The subviewport has a transparent BG
The Outliner camera ONLY sees layer 2
The 3DRender texture takes the view from the viewport
	and using a basic 2D outline shader, outlines everything that is solid red.
	It's not perfect becuase I did a lazy neighbor find method for that, but that can be modified.
	
This is not a particularly elegant method, but it does work. 
The main issue is making sure each mesh is on both layers, but you can modify import settings
