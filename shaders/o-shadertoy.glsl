// o-shader.glsl
// Original shader author: poopsock
// Adapted by: akai_hana

#version 430 core

// Uniforms (set these from your OpenGL application)
uniform vec2 resolution;
uniform float time;

// (The following two are declared but not actually used in this shader.
//  You can remove them if you don't need them elsewhere.)
uniform sampler1D samples;
uniform sampler1D fft;

// Output
out vec4 fragColor;

// Number of cells for noise
const int cell_amount = 2;
const vec2 period = vec2(5.0, 10.0);

// Wraps “dividend” into [0, divisor)
vec2 modulo(vec2 dividend, vec2 divisor) {
    vec2 positiveDividend = mod(dividend, divisor) + divisor;
    return mod(positiveDividend, divisor);
}

// Pseudo‐random gradient based on a 2D input
vec2 random(vec2 value) {
    value = vec2(
        dot(value, vec2(127.1, 311.7)),
        dot(value, vec2(269.5, 183.3))
    );
    return -1.0 + 2.0 * fract(sin(value) * 43758.5453123);
}

// 2D Perlin‐style noise
float noise(vec2 uv) {
    const vec2 _period = vec2(3.0);
    uv *= float(cell_amount);

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

    float lx = mix(
        dot(ll, fraction - vec2(0.0, 0.0)),
        dot(lr, fraction - vec2(1.0, 0.0)),
        blur.x
    );
    float ux = mix(
        dot(ul, fraction - vec2(0.0, 1.0)),
        dot(ur, fraction - vec2(1.0, 1.0)),
        blur.x
    );
    return mix(lx, ux, blur.y) * 0.8 + 0.5;
}

// Fractional Brownian Motion using the above noise
float fbm(vec2 uv) {
    float amplitude = 0.5;
    float frequency = 3.0;
    float value = 0.0;

    for (int i = 0; i < 6; i++) {
        value += amplitude * noise(frequency * uv);
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    return value;
}

// Convert (x,y) → (radius, angle) in polar coordinates
vec2 polar(vec2 uv, vec2 center, float zoom, float repeat) {
    vec2 dir = uv - center;
    float radius = length(dir) * 2.0;
    float angle = atan(dir.y, dir.x) * (1.0 / (3.14159265 * 2.0));
    return vec2(radius * zoom, angle * repeat);
}

// (Unused in this shader, placeholder for a circle SDF)
float sdfCircle(vec2 p, vec2 o, float r) {
    return 0.0;
}

void main() {
    // Early guard if resolution is invalid
    if (resolution.x <= 0.0 || resolution.y <= 0.0) {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0); // bright red for debug
        return;
    }

    // Normalize coords to roughly [–1, +1] on the longer axis, then quantize
    vec2 uv = (2.0 * gl_FragCoord.xy - resolution.xy) / resolution.y;
    uv = floor(uv * 1000.0) / 500.0;

    // Convert to polar space
    vec2 puv = polar(uv, vec2(0.0), 0.5, 1.0);
    float safeRadius = max(puv.x, 0.0001);

    // Define a milk‐themed palette
    vec3 milkBlack = vec3(0.05098039, 0.05098039, 0.07843137);
    vec3 milkGrey  = vec3(0.32156863, 0.14901961, 0.24313725);
    vec3 milkWhite = vec3(0.67450980, 0.19607843, 0.19607843);

    // Compute FBM noise, animated over time
    float n = fbm(
        puv * vec2(1.0, 1.0) +
        vec2(time * 0.2, 5.0 / safeRadius * -0.1) * 0.5
    );
    n = n * n / sqrt(safeRadius) * 0.8;

    // Base color is “milkBlack”
    vec3 c = milkBlack;

    // Thresholds for switching to grey/white
    if (n > 0.20) {
        c = milkGrey;
    }
    if (n > 0.25) {
        c = milkWhite;
    }
    if (puv.x < 0.4) {
        // Force black near the center
        c = milkBlack;
    }

    fragColor = vec4(c, 1.0);
}

