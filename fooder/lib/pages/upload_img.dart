import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadPredictScreen extends StatefulWidget {
  const UploadPredictScreen({super.key});

  @override
  State<UploadPredictScreen> createState() => _UploadPredictScreenState();
}

class _UploadPredictScreenState extends State<UploadPredictScreen> {
  File? _imageFile;
  String? _predictionResult;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _predictionResult = null; // 清空之前的結果
      });
    }
  }

  Future<void> _uploadAndPredict() async {
    if (_imageFile == null) return;

    setState(() {
      _isLoading = true;
    });

    final uri = Uri.parse('http://10.0.2.2:8000/predict'); // 注意這裡對 Android 模擬器是 10.0.2.2
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));

    try {
      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final decoded = json.decode(respStr);
        setState(() {
          _predictionResult = decoded['description'];
        });
      } else {
        setState(() {
          _predictionResult = '伺服器錯誤（${response.statusCode}）';
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = '發生錯誤：$e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("上傳圖片進行食物辨識")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 200)
                : Text("尚未選擇圖片"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("從相簿選擇圖片"),
            ),
            const SizedBox(height: 20),
            if (_imageFile != null)
              ElevatedButton(
                onPressed: _uploadAndPredict,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("送出圖片辨識"),
              ),
            const SizedBox(height: 20),
            if (_predictionResult != null)
              Text("辨識結果：$_predictionResult",
                  style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}