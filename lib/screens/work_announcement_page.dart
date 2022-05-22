import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/ui_components/custom_app_bar.dart';
import 'package:multimeister/ui_components/custom_carousel_slider.dart';
import '../models/review_model.dart';
import '../models/work_model.dart';
import '../ui_components/custom_button.dart';
import '../ui_components/review_tile.dart';
import '../ui_components/ui_specs.dart';

class WorkAnnouncementPage extends StatefulWidget {
  final Work work;
  const WorkAnnouncementPage({Key? key, required this.work}) : super(key: key);

  @override
  State<WorkAnnouncementPage> createState() => _WorkAnnouncementPageState();
}

class _WorkAnnouncementPageState extends State<WorkAnnouncementPage> {
  // dummy lists for now
  List<Image> images = [
    Image.asset("assets/images/placeholder-image.png"),
    Image.asset("assets/images/placeholder-image.png"),
    Image.asset("assets/images/placeholder-image.png"),
    Image.asset("assets/images/placeholder-image.png"),
  ];
  List<Review> reviewList = [
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
          child: Container(
              child: Center(
                  child: Column(children: [
        SizedBox(height: AppMargins.M),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargins.L),
          child: Text(
            widget.work.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppFontSizes.XXL, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: AppMargins.S),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
          child: Text("Tamplarie", style: TextStyle(fontSize: AppFontSizes.XL)),
        ),
        SizedBox(height: AppMargins.M),
        CustomButton(
          text: "Contacteaza",
          onPressed: () {
            //TODO: open message dialog
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppMargins.M, horizontal: AppMargins.S),
          child: Text(widget.work.description,
              style: TextStyle(fontSize: AppFontSizes.M)),
        ),
        Padding(
          padding: EdgeInsets.all(AppMargins.S),
          child: CustomCarouselSlider(images: images),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppMargins.S),
                child: CircleAvatar(
                  //TODO: add profile photo if it exists
                  backgroundColor: AppColors.Yellow,
                  foregroundColor: Colors.white,
                  child: Text(widget.work.meisterName[0]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppMargins.S),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.work.meisterName,
                      style: TextStyle(
                          fontSize: AppFontSizes.M, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Text(widget.work.meisterCity,
                        style: TextStyle(
                            fontSize: AppFontSizes.M, color: Colors.grey)),
                    Text(widget.work.meisterPhone,
                        style: TextStyle(
                            fontSize: AppFontSizes.M, color: Colors.grey))
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: RatingBar.builder(
                itemCount: 5,
                itemSize: 25,
                initialRating: widget.work.rating ?? 0,
                ignoreGestures: true,
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (rating) {}),
          ),
          SizedBox(
            width: AppMargins.M,
          ),
        ]),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(AppMargins.S),
            child: Text(
              "Recenzii",
              style: TextStyle(
                  fontSize: AppFontSizes.XL, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviewList.length,
            itemBuilder: (BuildContext context, int index) {
              return ReviewTile(
                name: reviewList[index].reviewerName,
                area: reviewList[index].area,
                phone: reviewList[index].phone,
                rating: reviewList[index].rating,
              );
            }),
      ])))),
    );
  }
}
