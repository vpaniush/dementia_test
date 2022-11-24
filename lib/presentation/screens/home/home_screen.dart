import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PainterController _controller;

  @override
  void initState() {
    _controller = PainterController();
    _controller.thickness = 5.0;
    _controller.backgroundColor = Colors.transparent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painter Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _controller.clear,
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.amber,
            ),
          ),
          Painter(_controller),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
