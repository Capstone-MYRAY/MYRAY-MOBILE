import 'package:flutter/material.dart';

class FarmerJobPostView extends StatelessWidget {
  const FarmerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobPostView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JobPostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
