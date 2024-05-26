#ifdef GL_ES
precision mediump float;
#endif

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir;

void main() {
  float intensity = max(0.0, dot(ecNormal, lightDir));
  vec3 color = vec3(intensity);
  gl_FragColor = vec4(color * vertColor.rgb, 1.0);
}
