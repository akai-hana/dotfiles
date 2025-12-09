#ifdef GL_ES
precision lowp float;
#endif

uniform vec2 mouse;
uniform float time;
uniform vec2 resolution;

float torusSDF(vec3 p, float radius){  
     return length( vec2( length(p.xz) - 1., p.y) ) - radius;   
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * resolution.xy)/resolution.y;
    //uv = floor(uv * 200.) / 200.;
    float t = time * .02;
    
    uv *= mat2(cos(t),-sin(t), sin(t), cos(t)); // camera rotation
    
    //camera code
    vec3 ro = vec3(0,0,-1);  // camera position - ray origin
    vec3 lookat = mix(vec3(0),vec3(-.7,0,-.7), sin(t*1.56)*.5+.5);// steering point of camera
    float zoom = mix(.2, .7, sin(t)*.5+.5); // audio mod: field of view
    
    // we need to deine the three directions with respect to the camera POV:
    // we use a forward vector which points toward the virtual screen, a right and an up component
    // we use the cross product, which always yields an orthogonal vector wrt the plane defined by the input vectors
    vec3 f = normalize(lookat-ro), // forward vector: look direction camera
        r = normalize(cross(vec3(0,1,0), f)), //right vector: points to the right of the  forward vector
        u = cross(f,r), // up vector: points up wrt the forward vector
        c = ro + f*zoom, //camera center
        i = c + uv.x * r + uv.y * u, // intersection point, where camera ray intersects the virtual screen
        rd = normalize(i-ro);

    float radius = mix(.3, .9, sin(t*.5)*.5+.5);//radius of toroid
    // Ray Marcher
    float dS, dO = 0.0; 
    vec3 p; 
    for(int i = 0; i < 100; i++){
        p = ro + dO*rd;
        dS = - (torusSDF(p, radius)); //the minus is needed to get \"inside\" the torus
        if(dS < .001) break;
        dO += dS;
    }
    
    vec3 col = vec3(0.0);
    // if the ray marcher hits something ( i.e., the dS is small )
    // take the points on the sufrace of the torus ( p inside the if. ) and draw on the surface
    if(dS < .001){
        float x = atan(p.x, p.z)+t * .5;             // from -pi to pi
        float y = atan(length(p.xz) - 1., p.y); // from -pi to pi
        float bands = sin(y*10.+x*20.); // 10. 20. modulable by audio
        float waves = sin(x*2.-y*6.+ t * 37.);
        
        float b1 = smoothstep(-.2, .2, bands);
        float b2 = smoothstep(-.2, .2, bands-0.5); //.5 narrows the white part (audioMOD)
        
        float m = b1*(1. - b2);
        m = max(m, b2 * max(0., waves));
        m +=max(0., waves * .3 * b2);
        
        col += m;
        col = smoothstep(.0, 0.1, col);
        
    }

    // Output to screen
    fragColor = vec4(col,1.0);
    float avg = (fragColor.r + fragColor.g + fragColor.b) / 3.0;
    vec4 milkBlack = vec4(vec3(0.050980392156862744, 0.050980392156862744, 0.0784313725490196), 1.0);
    vec4 milkGrey = vec4(vec3(0.3215686274509804, 0.14901960784313725, 0.24313725490196078), 1.0);
    vec4 milkWhite = vec4(vec3(0.6745098039215687, 0.19607843137254902, 0.19607843137254902), 1.0);

    avg = floor(avg * 2.);
    fragColor = mix(milkBlack, milkWhite, floor(avg / 2.));
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
