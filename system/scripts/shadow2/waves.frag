#ifdef GL_ES
precision lowp float;
#endif

uniform vec2 mouse;
uniform float time;
uniform vec2 resolution;

// simple noise from: https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83
float rand(float n) {
    return fract(sin(n) * 43758.5453123);
}

float noise(float p) {
    float fl = floor(p);
    float fc = fract(p);
    return mix(rand(fl), rand(fl + 1.0), fc);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (2. * fragCoord - resolution.xy) / resolution.y;
    //uv = floor(uv * 200.) / 200.;
    uv.x += 0.2 * sin(time / 5. + uv.y * 4.);
    float numLines = 15. + fragCoord.y * 0.05;
    float colNoise = noise(0.6 * uv.x * numLines);
    float colStripes = 0.5 + 0.5 * sin(uv.x * numLines * 0.75);
    float col = mix(colNoise, colStripes, 0.25 * sin(time / 10.));
    float aA = 1./5.;//(resolution.x * 0.005);
    col = smoothstep(0.5 - aA, 0.5 + aA, col);
    fragColor = vec4(vec3(col),1.0);
    float avg = (fragColor.r + fragColor.g + fragColor.b) / 3.0;
    vec4 milkBlack = vec4(vec3(0.050980392156862744, 0.050980392156862744, 0.0784313725490196), 1.0);
    vec4 milkGrey = vec4(vec3(0.3215686274509804, 0.14901960784313725, 0.24313725490196078), 1.0);
    vec4 milkWhite = vec4(vec3(0.6745098039215687, 0.19607843137254902, 0.19607843137254902), 1.0);

    avg = floor(avg * 2.);
    fragColor = mix(mix(milkBlack, milkGrey, avg), milkWhite, floor(avg / 2.));
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
