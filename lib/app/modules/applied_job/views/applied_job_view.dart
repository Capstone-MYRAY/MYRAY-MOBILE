import 'package:flutter/material.dart';

class AppliedJobView extends StatelessWidget {
  const AppliedJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppliedJobView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AppliedJobView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
