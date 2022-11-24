import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _hour;
  late final PainterController _controller;

  @override
  void initState() {
    _controller = PainterController();
    _controller.thickness = 10;
    _controller.backgroundColor = Colors.transparent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Dementia Test'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _controller.clear,
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 400,
              child: Stack(
                children: [
                  Center(child: Image.asset('assets/clock.png')),
                  Painter(_controller),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
