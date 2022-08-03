

import 'package:flutter/material.dart';

class HistoryAppliedJobView extends StatelessWidget {
  const HistoryAppliedJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Các công việc ứng tuyển'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Danh sách các việc đã ứng tuyển'),
      )
    );
  }
}