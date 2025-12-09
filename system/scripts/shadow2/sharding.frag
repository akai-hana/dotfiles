#ifdef GL_ES
precision lowp float;
#endif

uniform vec2 mouse;
uniform float time;
uniform vec2 resolution;

void mainImage(out vec4 c, vec2 p) {
    vec2 uv = .275 * p.xy / resolution.y;
    //uv = floor(uv * 1500.) / 1500.;
    float t = time*.001 + 3., k = cos(t), l = sin(t);        
    
    float s = .2;
    for(int i=0; i<64; ++i) {
        uv  = abs(uv) - s;    // Mirror
        uv *= mat2(k,-l,l,k); // Rotate
        s  *= .95156;         // Scale
    }
    
    float x = .5 + .5*cos(6.28318*(40.*length(uv)));

    c = vec4(vec3(x),1);
    c = .5+.5*cos(7.47128*(40.*length(uv)*vec4(1,2,3,4)));
    float avg = (c.r + c.g + c.b) / 3.;
    vec4 milkBlack = vec4(vec3(0.050980392156862744, 0.050980392156862744, 0.0784313725490196), 1.0);
    vec4 milkGrey = vec4(vec3(0.3215686274509804, 0.14901960784313725, 0.24313725490196078), 1.0);
    vec4 milkWhite = vec4(vec3(0.6745098039215687, 0.19607843137254902, 0.19607843137254902), 1.0);

    avg = floor(avg * 2.);
    c = mix(mix(milkBlack, milkGrey, avg), milkWhite, avg);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
