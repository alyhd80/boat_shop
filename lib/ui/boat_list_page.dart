import 'package:boat_shop/widget/animated_custom_appbar.dart';
import 'package:flutter/material.dart';

import '../data/local.dart';
import 'app_detail_page.dart';

const int timeAnimation = 560;

class BoatListPage extends StatefulWidget {
  const BoatListPage({Key? key}) : super(key: key);

  @override
  State<BoatListPage> createState() => _BoatListPageState();
}

class _BoatListPageState extends State<BoatListPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  double page = 0.0;
  double currentAppBarPosition = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(_listScroll);
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        reverseDuration: Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _pageController.removeListener(_listScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _listScroll() {
    setState(() {
      page = _pageController.page!;
    });
  }

  Future<void> onTap(Boat boat) async {
    _animationController.forward();
    setState(() {
      currentAppBarPosition = -20;
    });
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: BoatDetailPage(boat: boat),
          );
        },
      ),
    );
    setState(() {
      currentAppBarPosition = 0;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              child: Container(
                width: size.width,
                child: Text(
                  "Boats",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: size.width,
              height: size.height - 110,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: Boat.listBoat.length,
                  itemBuilder: (context, index) {
                    final percent = (page - index).abs().clamp(0.0, 1.0);
                    final scale = (page - index).abs().clamp(0.0, 0.3);
                    final opacity = percent.clamp(0.0, 0.6);
                    final boat = Boat.listBoat[index];

                    return Transform.scale(
                      scale: 1 - scale,
                      child: Opacity(
                        opacity: (1 - opacity),
                        child: boatWidget(
                            boat: boat, size: size, onTap: () => onTap(boat)),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Widget boatWidget(
    {required Boat boat, required Size size, required VoidCallback? onTap}) {
  return Container(
    width: size.width * 0.8,
    height: size.height * 0.8,
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Image.asset(
          boat.image,
          width: size.width * .35,
          height: size.height * .6,
        ),
        Text(
          boat.title,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${boat.subTitle}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "Specs >",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4540A4),
                letterSpacing: 1.2),
          ),
        )
      ],
    ),
  );
}
