import 'package:flutter/material.dart';

import '../data/local.dart';
import '../widget/app_bar.dart';
import '../widget/title_boat.dart';
import 'app_detail_page.dart';


const int timeAnimation = 560;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationCtr;

  late Animation<double> rotacion;
  late Animation<double> _xOffsetBoat;
  late Animation<double> _yOffsetBoat;
  late Animation<double> opacity;

  final _pageController = PageController(viewportFraction: 0.66);
  double _currentPage = 0.0;
  bool _isDetail = false;

  void _listener() {
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  @override
  void initState() {
    animationCtr = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: timeAnimation),
    );
    rotacion = Tween(begin: 0.0, end: -1.57).animate(CurvedAnimation(
        parent: animationCtr, curve: Cubic(0.68, -0.4, 0.265, 1.4)));

    _xOffsetBoat = Tween(begin: 0.0, end: 60.0).animate(CurvedAnimation(
        parent: animationCtr, curve: Cubic(0.68, -0.4, 0.265, 1.4)));

    _yOffsetBoat = Tween(begin: 0.0, end: 176.0).animate(CurvedAnimation(
        parent: animationCtr, curve: Cubic(0.68, -0.4, 0.265, 1.4)));
    //Curves.Curves.easeInOutBack
    opacity = CurvedAnimation(
        parent: animationCtr, curve: Interval(0.3, 0.9, curve: Curves.linear));

    _pageController.addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                AnimatedBuilder(
                  child: const AppBarBoat(),
                  animation: animationCtr,
                  builder: ( context,  child) {
                    return Transform.translate(
                        offset: Offset(0, opacity.value * -28),
                        child: Opacity(
                          opacity: 1 - opacity.value,
                          child: child,
                        ));
                  },
                ),
                Container(
                  child: PageView.builder(
                    physics: !_isDetail
                        ? BouncingScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: Data.boats.length,
                    itemBuilder: (BuildContext context, int i) {
                      final percentLeft = (_currentPage - i);
                      final percentRight = (i - _currentPage);

                      final scaleLetf = (percentLeft - 0.4).clamp(0.0, 0.3);
                      final scaleRight = (percentRight - 0.4).clamp(0.0, 0.3);

                      final opacityLetf = percentLeft.clamp(0.0, 1.0);
                      final opacityRight = percentRight.clamp(0.0, 1.0);
                      return Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Opacity(
                            opacity: (i < _currentPage)
                                ? (1 - opacityLetf)
                                : (1 - opacityRight),
                            child: Column(
                              children: [
                                Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..scale((i < _currentPage)
                                          ? 1 - scaleLetf
                                          : 1 - scaleRight),
                                    child: AnimatedBuilder(
                                      child: Container(
                                        child: Image(
                                          image: AssetImage(Data.boats[i].img),
                                          width: size.width * 0.4,
                                          height: size.height * 0.6,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      animation: animationCtr,
                                      builder:
                                          ( context,  child) {
                                        return Transform.translate(
                                          offset: Offset(_xOffsetBoat.value,
                                              -_yOffsetBoat.value),
                                          child: Transform.rotate(
                                              angle: rotacion.value,
                                              child: child),
                                        );
                                      },
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                AnimatedBuilder(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      TitleBoat(
                                        title: Data.boats[i].title,
                                        by: Data.boats[i].by,
                                        isDetail: false,
                                      ),
                                      GestureDetector(
                                          onTap: !_isDetail
                                              ? () {
                                            _isDetail = true;
                                            animationCtr.forward();
                                            setState(() {});
                                          }
                                              : null,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'SPEC',
                                                  style: TextStyle(
                                                      color: Color(0xff192298),
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      letterSpacing: 1.5),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xff192298),
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  animation: animationCtr,
                                  builder:
                                      ( context,  child) {
                                    return Opacity(
                                        opacity: 1 - opacity.value,
                                        child: child);
                                  },
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ),
                //Detalle
                _isDetail
                    ? Container(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 30, bottom: 20),
                      child: DeatilBoat(
                          controller: animationCtr,
                          animation: opacity,
                          currentPage: _currentPage.toInt(),
                          animationReverse:animationReverse
                      ),
                    ))
                    : Container(),
              ],
            )),
      ),
    );
  }

  animationReverse() {
    if (_isDetail) {
      animationCtr.reverse();
      Future.delayed(Duration(milliseconds: timeAnimation), () {
        _isDetail = false;
        setState(() {});
      });
    } else {
      return null;
    }
  }
}
