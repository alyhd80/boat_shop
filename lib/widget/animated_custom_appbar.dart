import 'package:flutter/material.dart';

class AnimatedCustomAppBar extends StatelessWidget {
  final bool animate;

  const AnimatedCustomAppBar({Key? key, required this.animate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 600),
      transform: Matrix4.translationValues(0, animate ? -100 : 0, 0),
      child: AnimatedOpacity(
        curve: Curves.fastOutSlowIn,
        opacity: animate ? 0 : 1,
        duration: Duration(milliseconds: 600),
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Boats",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[800],
                      size: 40,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
