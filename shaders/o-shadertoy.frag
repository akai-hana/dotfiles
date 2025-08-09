#version 330 core
out vec4 FragColor;
uniform vec3 iResolution; // Resolution of the shader window
uniform float iTime; // Time in seconds since start of rendering (goes back to 0 after 60 seconds)
uniform float iTimeDelta; // Time in seconds since last frame
uniform float iBatteryLevel; // Battery level of your pc, from 0 (empty) to 1 (full)
uniform float iLocalTime; // Local time of your pc, from 0 (12 am) to 1 (11:59:59 pm)
uniform vec4 iMouse; // Position of your mouse (z and w components unused as of now)
uniform sampler2D myTexture; // Texture extracted from a jpeg file
// Original shader author: poopsock
// Extracted and adapted to Shadertoy by: akai_hana
int cell_amount = 2;
vec2 period = vec2(5., 10.);
vec2 modulo(vec2 divident, vec2 divisor){
	vec2 positiveDivident = mod(divident, divisor) + divisor;
	return mod(positiveDivident, divisor);
}
vec2 random(vec2 value){
	value = vec2( dot(value, vec2(127.1,311.7) ),
				  dot(value, vec2(269.5,183.3) ) );
	return -1.0 + 2.0 * fract(sin(value) * 43758.5453123);
}
float noise(vec2 uv) {
    vec2 _period = vec2(3.);
	uv = uv * float(cell_amount);
	vec2 cMin = floor(uv);
	vec2 cMax = ceil(uv);
	vec2 uvFract = fract(uv);
	
	cMin = modulo(cMin, _period);
	cMax = modulo(cMax, _period);
	
	vec2 blur = smoothstep(0.0, 1.0, uvFract);
	
	vec2 ll = random(vec2(cMin.x, cMin.y));
	vec2 lr = random(vec2(cMax.x, cMin.y));
	vec2 ul = random(vec2(cMin.x, cMax.y));
	vec2 ur = random(vec2(cMax.x, cMax.y));
	
	vec2 fraction = fract(uv);
	
	return mix( mix( dot( ll, fraction - vec2(0, 0) ),
                     dot( lr, fraction - vec2(1, 0) ), blur.x),
                mix( dot( ul, fraction - vec2(0, 1) ),
                     dot( ur, fraction - vec2(1, 1) ), blur.x), blur.y) * 0.8 + 0.5;
}
float fbm(vec2 uv) {
    float amplitude = 0.5;
    float frequency = 3.0;
	float value = 0.0;
	
    for(int i = 0; i < 6; i++) {
        value += amplitude * noise(frequency * uv);
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    return value;
}
vec2 polar(vec2 uv, vec2 center, float zoom, float repeat)
{
	vec2 dir = uv - center;
	float radius = length(dir) * 2.0;
	float angle = atan(dir.y, dir.x) * 1.0/(3.1416 * 2.0);
	return vec2(radius * zoom, angle * repeat);
}
float sdfCircle(vec2 p, vec2 o, float r) {
    return 0.0;
}
// Replace your mainImage with this temporarily
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    
    // Simple moving dot - any timing hiccup will be very obvious
    float x = fract(iTime * 0.2); // Moves across screen in 5 seconds
    float dot = smoothstep(0.02, 0.01, abs(uv.x - x));
    
    fragColor = vec4(vec3(dot), 1.0);
}void main()
{
    mainImage(FragColor, gl_FragCoord.xy);
}
