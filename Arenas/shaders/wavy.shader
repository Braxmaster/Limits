shader_type canvas_item;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void vertex(){
	float random = rand(VERTEX.xy);
	VERTEX.x += cos(TIME * (random * 2.0) + VERTEX.y + VERTEX.x) * 1.2;
	VERTEX.y += sin(TIME * (random * 7.0) + VERTEX.x + VERTEX.y) * 1.2;
	}
	
