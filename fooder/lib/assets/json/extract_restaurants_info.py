import json
import sys

def extract_place_details(input_json_string):
    # 解析JSON字串
    data = json.loads(input_json_string)
    
    # 初始化結果列表
    results = []
    
    # 處理每個項目（假設data是一個列表）
    # 如果data不是列表而是單一對象，我們只處理該對象
    if not isinstance(data, list):
        data = [data]
    
    for index, item in enumerate(data):
        # 提取需要的字段，使用get()來優雅地處理缺失字段
        extracted_item = {
            "id": index + 1,  # 添加有序ID（從1開始）
            "name": item.get("name", ""),
            "formatted_address": item.get("formatted_address", ""),
            "formatted_phone_number": item.get("formatted_phone_number", ""),
            "website": item.get("website", ""),
            "url": item.get("url", ""),
            "types": item.get("types", []),
            "rating": item.get("rating", None),
            "user_ratings_total": item.get("user_ratings_total", 0)
        }
        
        # 處理weekday_text（嵌套在opening_hours下）
        if "opening_hours" in item and "weekday_text" in item["opening_hours"]:
            extracted_item["weekday_text"] = item["opening_hours"]["weekday_text"]
        else:
            extracted_item["weekday_text"] = []
        
        results.append(extracted_item)
    
    return results

# 主程式
if __name__ == "__main__":
    input_file = "/mnt/c/Users/h2so4/Desktop/Fooder/fooder/lib/assets/json/recommend_restaurants.json"  # 修改為您的JSON檔案名稱
    output_file = "/mnt/c/Users/h2so4/Desktop/Fooder/fooder/lib/assets/json/extracted_recommend_restaurants.json"
    
    # input_file = "/mnt/c/Users/h2so4/Desktop/Fooder/fooder/lib/assets/json/unknown_restaurants.json"  # 修改為您的JSON檔案名稱
    # output_file = "/mnt/c/Users/h2so4/Desktop/Fooder/fooder/lib/assets/json/extracted_unknown_restaurants.json"

    try:
        # 讀取輸入JSON檔案
        with open(input_file, 'r', encoding='utf-8') as f:
            input_json = f.read()
        
        # 處理數據
        extracted_data = extract_place_details(input_json)
        
        # 將結果寫入輸出檔案
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(extracted_data, f, indent=2, ensure_ascii=False)
        
        print(f"成功處理數據並保存至 {output_file}")
        
    except FileNotFoundError:
        print(f"錯誤: 找不到檔案 '{input_file}'")
    except json.JSONDecodeError:
        print(f"錯誤: '{input_file}' 不是有效的JSON格式")
    except Exception as e:
        print(f"發生錯誤: {str(e)}")