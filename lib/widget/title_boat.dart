import 'package:flutter/material.dart';

class TitleBoat extends StatelessWidget {
  final String title;
  final String by;
  final bool isDetail;

  const TitleBoat(
      {required this.title, required this.by, required this.isDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      isDetail ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 28),
        ),
        const SizedBox(
          height: 2,
        ),
        Text.rich(
          TextSpan(
            text: 'By',
            children: [
              TextSpan(
                  text: ' $by',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.74)))
            ],
            style: TextStyle(color: Colors.black54),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
