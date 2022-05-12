import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<Image>? images;
  CustomCarouselSlider({List<Image>? images})
      : this.images =
            images ?? [Image.asset("assets/images/placeholder-image.png")];

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: widget.images!.map((item) {
          return Builder(builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.Yellow, width: 2)),
              child: item,
            );
          });
        }).toList(),
        options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 0.5,
            enableInfiniteScroll: false));
  }
}
