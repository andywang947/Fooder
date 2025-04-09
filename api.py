from fastapi import FastAPI, File, UploadFile
from pydantic import BaseModel
import shutil
import uuid
import sys
import os
sys.path.append(os.path.abspath("src"))

from food_analyzer.food_description import describe_food_image

app = FastAPI()

class NameInput(BaseModel):
    name: str

@app.post("/hello")
async def say_hello(input: NameInput):
    return {"message": f"Hello, {input.name}!"}


@app.post("/predict")
async def predict_food(file: UploadFile = File(...)):
    # 1. 儲存臨時檔案
    temp_filename = f"temp_{uuid.uuid4().hex}.jpg"
    with open(temp_filename, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # 2. 呼叫你原本的 function
    description = describe_food_image(temp_filename)

    # 3. 刪除臨時檔案（選擇性）
    os.remove(temp_filename)

    return {"description": description}