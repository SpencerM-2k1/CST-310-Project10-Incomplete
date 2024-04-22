#version 330 core // Specify OpenGL version

// Input from vertex shader
in vec3 FragPos; // Fragment position
in vec3 Normal; // Normal vector
in vec2 TexCoords; // Texture coordinates

// Output to screen
out vec4 color; // Output color to screen

// Uniforms
uniform vec3 lightColor; // Light color
uniform vec3 lightPos; // Light position
uniform vec3 viewPos; // View position
uniform sampler2D diffuseMap; // Diffuse texture map
uniform sampler2D normalMap; // Normal texture map
uniform sampler2D heightMap; // Height texture map
uniform sampler2D bumpMap; // Bump map texture

void main()
{
    // Ambient lighting
    float ambientStrength = 0.8;
    vec3 ambient = ambientStrength * lightColor;

    // Diffuse lighting
    vec3 norm = normalize(texture(normalMap, TexCoords).rgb * 2.0 - 1.0); // Use normal map
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;

    // Specular lighting
    float specularStrength = 0.5;
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;

    // Combine lighting components
    vec3 result = (ambient + diffuse + specular);

    // Sample diffuse texture
    vec3 texture1 = texture(diffuseMap, TexCoords).rgb;

    // Apply height mapping for parallax mapping
    float height = texture(heightMap, TexCoords).r;
    vec2 offset = height * norm.xy;

    // Calculate final texture coordinates
    vec2 texCoord = TexCoords + offset;

    // Final color calculation with lighting and textures
    color = vec4(result * texture1, 1.0);
}
