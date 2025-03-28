# Food Image Caption API (Gemini 1.5 Pro)

1. get your [GOOGLE_API_KEY](https://aistudio.google.com/app/apikey) and set up in `.env`
2. `pip install -r requirements.txt`
3. `python main.py`

## Example
input:

<img src="https://github.com/andywang947/Fooder/blob/VLM_food_description/food_photo/3.jpg?raw=true" width="300"/>

output:
```
{
  "type": "沾麵",
  "description": "一碗濃郁的沾麵，配料包含叉燒肉、雞肉、蝦子以及蔥花，麵條另外放置於碗中。
湯底呈現橘紅色，看起來相當濃稠。",
  "calorie_estimation": 750,
  "calorie_level": "中高",
  "tags": ["日式料理", "拉麵", "沾麵", "海鮮", "叉燒", "雞肉", "蝦子"]
}
```


[more detail](https://docs.google.com/document/d/1sZv4qGTIWvHC4RhcDrk93ME69Jt7pCi6jdJ93GJbQGw/edit?tab=t.0)
