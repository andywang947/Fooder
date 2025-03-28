import os
from dotenv import load_dotenv
import google.generativeai as genai

load_dotenv()
google_api_key = os.getenv("GOOGLE_API_KEY")
genai.configure(api_key=google_api_key)
model = genai.GenerativeModel('gemini-1.5-pro')

def describe_food_image(img_path):
    with open(img_path, "rb") as f:
        image_data = f.read()

    image_part = {
        "mime_type": "image/jpeg",
        "data": image_data
    }

    prompt = '''請用 JSON 格式輸出這張圖片的餐點辨識結果，格式為：{

                'type': '餐點種類', 
                'description': '餐點描述', 
                'calorie_estimation': '估計熱量(單位: kcal)，只輸出數字', 
                'calorie_level': 低|中|中高|高'
                'tags'：用 list 列出餐點的關鍵字，例如：['台式料理', '炸物', '花椰菜']

            }
            
            注意事項：
            1. type 必須明確，例如：炒飯、牛排、燒臘飯、健康餐盒等。
            2. calorie_estimation 只輸出數字。
            3. calorie_level 僅能選擇：低、中、中高、高 四種之一。
            4. tags 至少給出 3 個與餐點有關的關鍵字，使用中文。
            5. 僅輸出 JSON，勿輸出其他文字。

            '''

    # 圖片描述
    response = model.generate_content([image_part, prompt])
    return response.text