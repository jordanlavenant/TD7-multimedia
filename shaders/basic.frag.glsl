#version 150 core

// Données reçues du vertex shader
in vec3 lightDir;
in vec3 eyeVec;
in vec3 out_normal;

// couleur émise pour le pixel
out vec4 frag_color;

void main(void)
{
    // Normalisation des vecteurs
    vec3 L = normalize(lightDir);
    vec3 N = normalize(out_normal);
    vec3 E = normalize(eyeVec);

    // Calcul de l'intensité de la lumière diffuse
    float intensity = max(dot(L, N), 0.0);

    // Calcul de la composante spéculaire
    vec3 R = reflect(-L, N);
    float specular = pow(max(dot(R, E), 0.0), 2);

    // Couleur finale avec composante diffuse et spéculaire
    vec4 diffuse_color = vec4(0.2, 0.2, 0.2, 1.0) + 0.6 * intensity;
    vec4 specular_color = vec4(0.8, 0.8, 0.8, 1.0) * specular;

    frag_color = diffuse_color + specular_color;
}