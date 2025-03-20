# Fooder
Google docx: https://docs.google.com/document/d/1ABWhm2OhT9I7Lvmj5ywiixzJ1Q-OoBKHlVcCEJa_Irs/edit?tab=t.0

# User story

## Record what I eat today
User 想要輕鬆的紀錄今天吃過的東西，當作是一個日記來用。
(Ex: 只要上傳一張圖片，自動偵測這是什麼食物、什麼類別等等，直接建立起資料庫、好吃與否、健康程度、熱量…偵測出他的店名等等，把所有過程自動化完成資料庫，人工僅做簡易的 modify. )

Reference: ChatGPT, database, notion
### 開發  
輸入: 食物的照片  
輸出: 此食物的相關資訊，Ex: 熱量、類別(Ex: 燒臘、義大利麵...)、地點、時間、描述、Google 地圖的店名資訊、...  
Stage 1: 建立起 Benchmark, ex: 準備好十張圖片，並手動寫好對應的 label, 其中 5 張做為 validation, 5 張做為 testing.  
Stage 2: 開發，看能不能做好、分析穩定性、成功率...  
Stage 3: 若分析確認完成，整合進前端。  

## What food do I like ?
基於當前的位置，自動搜尋周遭的 google 地圖的好吃食物，然後進行配對。
情境就像是左滑右滑，慢慢地就會完成一個自己的感興趣清單
Stage 1: APP 裡 Call 好 google map API




Reference: Tinder, Steam

## What I will eat today
User 想要問今天晚餐要吃什麼，可以得到一個滿意的回答
過往假設兩人的聊天情境:
(
A:今天要吃什麼
B: 隨便啊，都可以
A: 那麥當勞好不好
B: 不健康
A: 那火鍋好不好
B: 昨天吃過了
A: 咖哩呢
B: 今天不想吃日式的
A: 那想吃飯還是麵
B: 不知道，都可以
A: 那牛肉麵好不好
B: 好欸可以欸
)
我們的功能: 再做一次左滑右滑，不過部分來源自資料庫(過往我們吃的東西)、另外一部分來源自過去滑出來的選項，並且答案基於當前位置周圍的搜尋。

## Change the style of the image
User 上傳了今天吃的東西的影像以後，想要把我們拍下來的圖片，轉換風格、濾鏡(Ex: 轉成什麼樣的電影色調、卡通風格、動漫風格等等…)，or 將影像轉換成圖片 icon 以便紀錄(Ex: 拍了一張拉麵，想要把它變成是個小 icon 給我丟到簡報，讓我們最終的簡報 icon 都是吃東西的紀錄)、也可以成為上傳 IG 的 icon。
