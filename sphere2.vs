#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;
layout (location = 3) in vec3 aTangent;
layout (location = 4) in vec3 aBitangent;

out VS_OUT {
    vec3 FragPos;
    vec2 TexCoords;
    vec3 TangentLightPos;
    vec3 TangentViewPos;
    vec3 TangentFragPos;
} vs_out;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

uniform vec3 lightPos;
uniform vec3 viewPos;

void main()
{
    gl_Position      = projection * view * model * vec4(aPos, 1.0);
    vs_out.FragPos   = vec3(model * vec4(aPos, 1.0));   
    vs_out.TexCoords = aTexCoords;    
    
    vec3 T   = normalize(mat3(model) * aTangent);
    vec3 B   = normalize(mat3(model) * aBitangent);
    vec3 N   = normalize(mat3(model) * aNormal);
    mat3 TBN = transpose(mat3(T, B, N));

    vs_out.TangentLightPos = TBN * lightPos;
    vs_out.TangentViewPos  = TBN * viewPos;
    vs_out.TangentFragPos  = TBN * vs_out.FragPos;
}

// #version 330 core
// layout (location = 0) in vec3 aPos; // Receives aPos
// layout (location = 1) in vec3 aNormal; // Receives aNormal
// 
// out vec3 FragPos; // Returns FragPos
// out vec3 Normal; // Returns Normal
// 
// uniform mat4 model; // Receives model uniform
// uniform mat4 view; // Receives view uniform
// uniform mat4 projection; // Receives projection uniform
// 
// void main() {
//     gl_Position = projection * view * vec4(aPos, 1.0f);  // Implements transformations - multiplies transformation vectors
//     FragPos = vec3(model * vec4(aPos, 1.0));  // Sets fragment position
//     Normal = mat3(transpose(inverse(model))) * aNormal;  // Normalizes
// }
