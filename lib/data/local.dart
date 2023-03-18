class Data {
  static List<Boats> boats = [
    Boats(title: 'X22 Lift', by: 'Mastercraft', img: 'assets/images/boat1.png'),
    Boats(title: 'X24 Fun', by: 'Mastercraft', img: 'assets/images/boat2.png'),
    Boats(title: 'Lagoon L50', by: 'Neokraft', img: 'assets/images/boat3.png'),
    Boats(title: 'Beneteau First 14', by: 'Neokraft', img: 'assets/images/boat4.png'),
  ];

  static List<String> gallery = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
  ];
}
class Boats {
  final String title;
  final String by;
  final String img;

  Boats({required this.title, required this.by, required this.img});
}

