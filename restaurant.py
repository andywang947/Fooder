import googlemaps
import requests
import json
from datetime import datetime

def get_current_location(api_key):
    """使用 Google Geolocation API 獲取精確位置"""
    try:
        url = f"https://www.googleapis.com/geolocation/v1/geolocate?key={api_key}"
        response = requests.post(url, json={})
        if response.status_code == 200:
            loc = response.json()["location"]
            print(f"取得位置: {loc['lat']}, {loc['lng']}")
            return loc["lat"], loc["lng"]
        else:
            raise RuntimeError(f"定位失敗: {response.status_code} {response.text}")
    except Exception as e:
        raise RuntimeError(f"定位發生錯誤: {e}")


def find_nearby_restaurants(api_key, location):
    """使用 Google Places API 搜尋附近餐廳"""
    gmaps = googlemaps.Client(key=api_key)
    
    try:
        places_result = gmaps.places_nearby(
            location=location,
            rank_by='distance',
            type='restaurant',
            open_now=True
        )

        return places_result.get('results', [])
    
    except Exception as e:
        print(f"搜尋餐廳時發生錯誤: {e}")
        return []

def display_restaurants(restaurants):
    """顯示餐廳資訊"""
    if not restaurants:
        print("附近沒有找到餐廳。")
        return

    #print(f"\n找到 {len(restaurants)} 家餐廳:")
    print("=" * 50)

    price_level_map = {
        0: '免費',
        1: '便宜',
        2: '中等',
        3: '偏貴',
        4: '非常貴',
    }

    for i, place in enumerate(restaurants, 1):
        name = place.get('name', '未知名稱')
        rating = place.get('rating', '無評分')
        total_ratings = place.get('user_ratings_total', 0)
        price_level = place.get('price_level', '未知')
        price_text = price_level_map.get(price_level, '未知') if isinstance(price_level, int) else '未知'
        vicinity = place.get('vicinity', '地址未知')

        print(f"{i}. {name}")
        print(f"   評分: {rating} ★ ({total_ratings}則評論)")
        print(f"   價格: {price_text}")
        print(f"   地址: {vicinity}")
        print("-" * 50)



def main():
    # 替換為你的 Google Maps API 金鑰（要啟用 Geolocation API + Places API）
    API_KEY = '#IzaSyAIqFFoZeA89of3iFIERvubMIBj7fCOPKQ'
    
    print("=== 附近餐廳搜尋程式 ===")
    
    # 獲取當前位置
    # print("\n獲取當前位置中...")
    location = get_current_location(API_KEY)
    # print(f"你的位置: 緯度 {location[0]}, 經度 {location[1]}")
    
    # 搜尋附近餐廳
    # print("\n搜尋附近餐廳中...")
    restaurants = find_nearby_restaurants(API_KEY, location)
    
    # 顯示結果
    display_restaurants(restaurants)
    

if __name__ == "__main__":
    main()
