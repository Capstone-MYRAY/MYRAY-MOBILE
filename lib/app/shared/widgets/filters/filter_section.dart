import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final Widget child;
  const FilterSection({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: 24.0,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
