
import 'package:flutter/material.dart';

import '../data/local.dart';
import '../widget/title_boat.dart';

class DeatilBoat extends StatelessWidget {
  DeatilBoat(
      {required this.animation,
        required this.controller,
        required this.currentPage,
        required this.animationReverse});

  final AnimationController controller;
  final int currentPage;
  final VoidCallback animationReverse;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: controller,
          child: _ExitButton(
            animationReverse: animationReverse,
          ),
          builder: ( context,  child) {
            return Opacity(opacity: animation.value, child: child);
          },
        ),
        const SizedBox(
          height: 120,
        ),
        AnimatedBuilder(
          animation: controller,
          child: _ContentDetail(
            index: currentPage,
          ),
          builder: ( context,  child) {
            return Opacity(
              opacity: animation.value,
              child: Transform.translate(
                offset: Offset(0, (1 - animation.value) * -40),
                child: child,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ExitButton extends StatelessWidget {
  _ExitButton({
    required this.animationReverse,
  });
  final VoidCallback animationReverse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: animationReverse,
      child: Container(
        alignment: Alignment.center,
        height: 32,
        width: 32,
        margin: EdgeInsets.only(left: 14),
        decoration:
        BoxDecoration(color: Color(0xffE8E4E8), shape: BoxShape.circle),
        child: Icon(
          Icons.clear,
          size: 20,
          color: Colors.black45,
        ),
      ),
    );
  }
}

class _ContentDetail extends StatelessWidget {
  final int index;

  _ContentDetail({required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: TitleBoat(
            title: Data.boats[index].title,
            by: Data.boats[index].by,
            isDetail: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            'Meet the highest-performing inboard \nwaterski boat ever created',
            style: TextStyle(color: Colors.black54),
            overflow: TextOverflow.clip,
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            'SPEC',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: _SpecsBoat(
            length: "24'2",
            beam: '102°',
            weight: '2767 KG',
            fuelCapacity: '322 L',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            'GALLERY',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.black54),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _ListGallery(),
      ],
    );
  }
}

class _SpecsBoat extends StatelessWidget {
  final String length;
  final String beam;
  final String weight;
  final String fuelCapacity;

  const _SpecsBoat(
      {required this.length,
        required this.beam,
        required this.weight,
        required this.fuelCapacity});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent),
      child: DataTable(
          sortAscending: false,
          horizontalMargin: 0,
          headingRowHeight: 12,
          dataRowHeight: 36,
          showCheckboxColumn: false,
          columns: [
            DataColumn(
              label: Text(''),
            ),
            DataColumn(label: Text('')),
          ],
          rows: [
            createSpec('Boat Length', length),
            createSpec('Beam', beam),
            createSpec('Wright', weight),
            createSpec('Fuel capacity', fuelCapacity),
          ]),
    );
  }

  DataRow createSpec(String name, String description) => DataRow(cells: [
    DataCell(
      Text(
        name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    DataCell(
      Text(
        description,
        style:
        TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.64)),
      ),
    ),
  ]);
}

class _ListGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: Data.gallery.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.only(left: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage(
                    Data.gallery[i],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

