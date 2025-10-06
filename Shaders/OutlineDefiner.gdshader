shader_type spatial;
render_mode unshaded;

const uint OTHER_LAYER = 1u;
const uint CHOSEN_LAYER = 2u;

// !!! This does not make an outline !!!
//it checks if it's visible on a camera layer then makes the object red
//Or invisible otherwise
void fragment() {
	if( (CAMERA_VISIBLE_LAYERS & OTHER_LAYER) == OTHER_LAYER ) {
		ALPHA = 0.0;
	}
	if( (CAMERA_VISIBLE_LAYERS & CHOSEN_LAYER) == CHOSEN_LAYER ) {
		ALBEDO = vec3(10.0, 0., 0.);
	}
}