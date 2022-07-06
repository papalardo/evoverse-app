import 'package:flutter/material.dart';

class MiningCardWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const MiningCardWidget({
    Key? key,
    required this.title,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF272f3b),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1f2329),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(10),
            child: child,
          )
        ],
      ),
    );
  }

}
