import 'package:tflite/tflite.dart';

class TestResultService {
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/network/model_unquant.tflite',
      labels: 'assets/network/labels.txt',
    );
  }

  Future<String> getTestResult({
    required String imagePath,
    required int time,
  }) async {
    final output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 12,
      threshold: 0.1,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    if (output != null) {
      final first = output.first;
      if (first['label'] != '$time' || first['label'] == '0') return '0';
      return (first['confidence'] * 100).toStringAsFixed(2);
    }
    return '0';
  }

  Future<void> dispose() async {
    await Tflite.close();
  }
}
