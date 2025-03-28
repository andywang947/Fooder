import sys
import os
sys.path.append(os.path.abspath("src"))

from food_analyzer.food_description import describe_food_image

img_path = 'food_photo/1.jpg'
img_description = describe_food_image(img_path)

print(img_description)