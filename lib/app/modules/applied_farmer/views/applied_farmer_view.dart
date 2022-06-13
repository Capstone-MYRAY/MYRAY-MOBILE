import 'package:flutter/material.dart';

class AppliedFarmerView extends StatelessWidget {
  const AppliedFarmerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppliedFarmerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AppliedFarmerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
