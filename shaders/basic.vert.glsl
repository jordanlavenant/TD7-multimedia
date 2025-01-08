#version 150 core
// version du langage GLSL utilisée, ici 4.5

// Uniformes pour les matrices model, view et proj
uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

// Uniforme pour la position de la source de lumière
uniform vec4 LightSource_position;

// in indique que la variable est fournie en entrée pour chaque point
// chaque point possède une position 3D
in vec3 in_pos;
in vec3 in_normal;

// Sorties vers le fragment shader
out vec3 lightDir;
out vec3 eyeVec;
out vec3 out_normal;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main(void)
{
    // Calcul de la position du vertex en coordonnées de l'oeil
    mat4 mv = view * model;
    vec4 vVertex = mv * vec4(in_pos, 1.0);
    eyeVec = -vVertex.xyz;

    // Transformation de la normale avec perturbation aléatoire
    vec3 perturbed_normal = in_normal + 0.5 * vec3(random(in_pos.xy), random(in_pos.yz), random(in_pos.zx));
    out_normal = mat3(transpose(inverse(mv))) * perturbed_normal;

    // Calcul de la direction de la lumière
    lightDir = vec3(LightSource_position.xyz - vVertex.xyz);

    // Perturbation de la position du point
    vec4 perturbed_pos = vec4(in_pos, 1.0) + 0.1 * random(in_pos.xy);

    // Calcul de la position finale du vertex avec perturbation
    gl_Position = proj * view * model * perturbed_pos;
}