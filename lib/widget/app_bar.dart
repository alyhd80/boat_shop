import 'package:flutter/material.dart';

class AppBarBoat extends StatelessWidget {
  const AppBarBoat();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Boats',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.search,size: 35,)
        ],
      ),
    );
  }
}
