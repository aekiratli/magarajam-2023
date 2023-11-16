extends Node2D

# 1 -> background
# 0 -> wall

func generate_noise(width: int, height: int, noise_density: float) -> Array:

    var generated_noise = []

    for x in range(width):

        for y in range(height):

            var noise = randf()

            if noise >= noise_density:
                noise = 1

            else:
                noise = 0

            generated_noise.append(noise)

    return generated_noise