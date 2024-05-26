#ifdef GL_ES
precision mediump float;
#endif

uniform mat4 transform;
uniform mat4 modelview;
uniform mat3 normalMatrix;
uniform float u_time;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir;

void main() {
  vec4 pos = position;
  pos.x += sin(u_time + position.y * 2.0) * 10.0;
  pos.y += cos(u_time + position.x * 2.0) * 10.0;

  gl_Position = transform * pos;
  
  ecNormal = normalize(normalMatrix * normal);
  vertColor = color;
  
  vec3 ecPosition = vec3(modelview * pos);
  lightDir = normalize(vec3(0.0, 0.0, 1.0) - ecPosition);
}
