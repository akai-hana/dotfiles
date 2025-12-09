// credits to DiggerDwarf at https://www.shadertoy.com/view/l3BXRV

#ifdef GL_ES
precision lowp float;
#endif

uniform vec2 mouse;
uniform float time;
uniform vec2 resolution;

float sdBox(vec3 o, vec3 r, vec3 p) {
    vec3 q = abs(p-o)-r;
    return length(max(q, 0.)) + min(max(q.x, max(q.y, q.z)), 5.);
}

vec3 rotated_x(vec3 v, float a) {
    return vec3(
        v.x,
        (v.y*cos(a)) - (v.z*sin(a)),
        (v.y*sin(a)) + (v.z*cos(a))
    );
}
vec3 rotated_y(vec3 v, float a) {
    return vec3(
        (v.x*cos(a))+(v.z*sin(a)),
        v.y,
        (v.z*cos(a))-(v.x*sin(a))
    );
}
vec3 rotated_z(vec3 v, float a) {
    return vec3(
        (v.x*cos(a))+(v.y*sin(a)),
        (v.y*cos(a))-(v.x*sin(a)),
        v.z
    );
}
float map(vec3 p) {
    float b1 = sdBox(vec3(0), vec3(.15), p-floor(p + 0.5));//-.05;
    return b1;
}
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 rep = vec2(1.0);
    float pi = 3.141592653;
    
    vec2 uv = fragCoord.xy/resolution.xy;
    uv = fract(uv*rep);
    uv = uv * 2.0 - 1.0;
    uv.x *= (resolution.x*rep.y) / (resolution.y*rep.x);

    //uv = floor(uv * 200.) / 200.;

    vec3 ro = vec3(.5, .5, fract(time/5.));
    vec3 rd = normalize(vec3(uv, 1));

    rd = rotated_x(rd, (sin(time / 20.) * 500. /resolution.y)*(pi/2.));
    rd = rotated_y(rd, (cos(time / 10.) * 300. /resolution.x-.5)*(pi/2.));

    float t = 0.0;
    float a;
    for (float i = 0.0 ; i < 25.0 ; i++) {
        a = map(ro);
        ro += rd*a;
        t += length(rd*a);
        if (t > 10.0) break;
    }

    fragColor = vec4(t/10.);
    
    float avg = (fragColor.r + fragColor.g + fragColor.b) / 3.0;
    vec4 milkBlack = vec4(vec3(0.050980392156862744, 0.050980392156862744, 0.0784313725490196), 1.0);
    vec4 milkGrey = vec4(vec3(0.3215686274509804, 0.14901960784313725, 0.24313725490196078), 1.0);
    vec4 milkWhite = vec4(vec3(0.6745098039215687, 0.19607843137254902, 0.19607843137254902), 1.0);
    
    avg = floor(avg * 2. - 0.01);
    fragColor = mix(mix(milkWhite, milkGrey, avg), milkBlack, floor(avg / 2.));
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
