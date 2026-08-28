import 'package:flutter/material.dart';

class MBMainHorizontalCarousel extends StatefulWidget {

  final List<Widget> items;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const MBMainHorizontalCarousel({
    super.key,
    required this.items,
    this.margin,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _MBMainHorizontalCarouselState();
}

class _MBMainHorizontalCarouselState extends State<MBMainHorizontalCarousel> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return widget.items[index];
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16);
        },
        itemCount: widget.items.length
      ),
    );
  }
}