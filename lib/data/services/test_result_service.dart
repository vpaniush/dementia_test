import 'package:tflite/tflite.dart';

class TestResultService {
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/network/model_unquant.tflite',
      labels: 'assets/network/labels.txt',
    );
  }

  Future<void> getTestResult(String imagePath) async {
    final output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 12,
      threshold: 0.1,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print(output);
  }

  Future<void> dispose() async {
    await Tflite.close();
  }
}
