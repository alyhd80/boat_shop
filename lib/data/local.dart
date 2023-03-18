class Boat {
  Boat({
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String image;
  final String subTitle;

  static final List<Boat> listBoat = [
    Boat(
      title: 'X22 Lift',
      subTitle: 'By Mastercraft',
      image: 'assets/images/boat1.png',
    ),
    Boat(
      title: 'X24 Fun',
      subTitle: 'By Mastercraft',
      image: 'assets/images/boat2.png',
    ),
    Boat(
      title: 'X24 Force',
      subTitle: 'By NeoKraft',
      image: 'assets/images/boat3.png',
    ),
    Boat(
      title: 'X24 Force',
      subTitle: 'By NeoKraft',
      image: 'assets/images/boat4.png',
    ), Boat(
      title: 'X24 Force',
      subTitle: 'By NeoKraft',
      image: 'assets/images/boat5.png',
    ),

  ];
}
