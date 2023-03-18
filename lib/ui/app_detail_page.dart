import 'package:boat_shop/data/local.dart';
import 'package:flutter/material.dart';
import "dart:math" show pi;

class BoatDetailPage extends StatefulWidget {
  final Boat boat;

  BoatDetailPage({Key? key, required this.boat}) : super(key: key);

  @override
  State<BoatDetailPage> createState() => _BoatDetailPageState();
}

class _BoatDetailPageState extends State<BoatDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController.forward(from: 0.0);
    _animationController.drive(CurveTween(curve: Curves.easeInOutBack));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        reverseCurve: Curves.easeInOutBack,
        parent: _animationController,
        curve: Curves.easeInOutBack));
    super.initState();
  }

  void onTapClose() {
    _animationController.reverse();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double initialPosition = size.width / 2 - (size.width / 2);
    double initialTop = size.height * .11;

    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            double value = _animationController.value;
            double currentTop = 0 - initialTop * value + initialTop;
            return Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: currentTop,
                    left: value == 0 ? initialPosition : 120,
                    child: Transform.scale(
                      scale: 1.8 * animation.value,
                      child: Transform.rotate(
                        angle: pi / 180 * (-90 * value),
                        child: Image.asset(
                          widget.boat.image,
                          width: size.width,
                          height:
                              value == 0 ? size.height * .6 : size.height * .4,
                        ),
                      ),
                    ),
                  ),

                  ///title
                  Positioned(
                      top: size.height * .4,
                      child: Opacity(
                        opacity: value,
                        child: SingleChildScrollView(
                          child: Container(
                            width: size.width,
                            height: size.height * .6 - 10,
                            padding: EdgeInsets.only(left: 20),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  top: 0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.boat.title,
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(widget.boat.subTitle)

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),

                ],
              ),
            );
          }),
    );
  }
}
