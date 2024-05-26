#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

void main() {
  vec2 st = gl_FragCoord.xy / u_resolution;
  vec3 color = vec3(0.0);

  float pct = abs(sin(u_time + st.x * 10.0));
  color = mix(vec3(1.0, 0.5, 0.5), vec3(0.5, 0.5, 1.0), pct);

  gl_FragColor = vec4(color, 1.0);
}
