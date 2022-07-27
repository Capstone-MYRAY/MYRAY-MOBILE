import 'package:flutter/material.dart';

class LandownerGuidePostView extends StatelessWidget {
  const LandownerGuidePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài hướng dẫn'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Guidepost here'),
      ),
    );
  }
}
