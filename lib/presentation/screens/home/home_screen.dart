import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dementia_test/data/services/test_result_service.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _time;
  late final TestResultService _resultService;
  late final ScreenshotController _screenshotController;
  late final PainterController _painterController;

  @override
  void initState() {
    _resultService = TestResultService();
    _screenshotController = ScreenshotController();
    _painterController = PainterController();
    _painterController.thickness = 10;
    _painterController.backgroundColor = Colors.transparent;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _resultService.loadModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Dementia Test')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _task(),
            _clock(),
            _buttons(),
          ],
        ),
      );

  Widget _clock() => SizedBox(
        height: 400,
        child: Screenshot(
          controller: _screenshotController,
          child: Stack(
            children: [
              Center(child: Image.asset('assets/clock.png')),
              Painter(_painterController),
            ],
          ),
        ),
      );

  Widget _task() => SizedBox(
        height: 20,
        child: _time != null
            ? Text(
                "Please, draw $_time o'clock on the clock",
                style: _textStyle().copyWith(fontWeight: FontWeight.w700),
              )
            : null,
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _newTime,
            child: Text('New time', style: _textStyle()),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: Text('Submit', style: _textStyle()),
          ),
        ],
      );

  void _newTime() {
    _painterController.clear();
    final Random random = Random();
    final newTime = random.nextInt(12) + 1;
    setState(() {
      _time = newTime;
    });
  }

  void _submit() async {
    Uint8List? imageUint = await _screenshotController.capture();
    if (imageUint != null) {
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(imageUint);
      await _resultService.getTestResult(file.path);
    }
  }

  @override
  void dispose() {
    _painterController.dispose();
    super.dispose();
  }

  TextStyle _textStyle() => const TextStyle(fontSize: 18);
}
