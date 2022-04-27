import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

import 'custom_button.dart';

class WorkCard extends StatefulWidget {
  final String name;
  final String area;
  final String phone;
  final double? rating;
  final Image? image;
  final String title;
  final String label;
  final String description;
  const WorkCard(
      {Key? key,
      required this.name,
      required this.area,
      required this.phone,
      required this.title,
      required this.label,
      required this.description,
      this.rating,
      this.image})
      : super(key: key);

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(AppMargins.M),
        child: Card(
          shadowColor: AppColors.DarkGray,
          elevation: 3,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: AppMargins.S),
                    child: CircleAvatar(
                      //TODO: add profile photo if it exists
                      backgroundColor: AppColors.Yellow,
                      foregroundColor: Colors.white,
                      child: Text(widget.name[0]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppMargins.S),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: AppFontSizes.M, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(widget.area,
                            style: TextStyle(
                                fontSize: AppFontSizes.M, color: Colors.grey)),
                        Text(widget.phone,
                            style: TextStyle(
                                fontSize: AppFontSizes.M, color: Colors.grey))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: AppMargins.M,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(AppMargins.S),
                child: RatingBar.builder(
                    itemCount: 5,
                    itemSize: 25,
                    initialRating: widget.rating ?? 0,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {}),
              ),
            ]),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
              child: widget.image ??
                  Image.asset("assets/images/placeholder-image.png"),
            ),
            SizedBox(
              height: AppMargins.M,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: AppFontSizes.L, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
              child: Text(
                widget.label,
                style: TextStyle(fontSize: AppFontSizes.M, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppMargins.S, vertical: AppMargins.M),
              child: Text(
                widget.description,
                style: TextStyle(fontSize: AppFontSizes.S, color: Colors.grey),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(AppMargins.S),
                child: CustomButton(
                  text: "Contacteaza",
                  onPressed: () {
                    //TODO: open message dialog
                  },
                ),
              ),
            )
          ]),
        ));
  }
}
