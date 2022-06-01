import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/screens/add_review.dart';
import 'package:multimeister/services/database.dart';
import 'package:multimeister/services/hive.dart';
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
  final loggedUser = HiveServices().getUserData();
  final DatabaseService databaseService = DatabaseService();

  // dummy lists for now
  List<Image> images = [
    Image.asset("assets/images/placeholder-image.png"),
    Image.asset("assets/images/placeholder-image.png"),
    Image.asset("assets/images/placeholder-image.png"),
    Image.asset("assets/images/placeholder-image.png"),
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
        // SizedBox(height: AppMargins.M),
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
        SizedBox(height: AppMargins.S),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Material(
            borderRadius: BorderRadius.circular(5),
            shadowColor: Colors.black,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(
                  widget.work.meisterName,
                  style: TextStyle(
                        fontSize: AppFontSizes.XL, color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(widget.work.meisterCity,
                    style: TextStyle(
                        fontSize: AppFontSizes.L, color: Colors.grey)),
                SizedBox(height: 30),
                Text("Rating lucrare: " + widget.work.rating!.toStringAsFixed(2) + "/5",
                    style: TextStyle(
                        fontSize: AppFontSizes.XL, color: Colors.black)),
                Padding(
                    padding: EdgeInsets.all(AppMargins.S),
                    child: RatingBar.builder(
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        initialRating: widget.work.rating ?? 0,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (rating) {}),
                  ),
                SizedBox(height: AppMargins.S),
                Text(widget.work.meisterPhone,
                    style: TextStyle(
                        fontSize: AppFontSizes.XL, color: Colors.black)),
                SizedBox(height: AppMargins.S),
                CustomButton(
                  text: "Contacteaza",
                  onPressed: () {
                    //TODO: open message dialog
                  },
                ),
                SizedBox(height: AppMargins.S,),
                CustomButton(
                      text: "Adauga recenzie",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddReviewPage(
                                reviewerUid: loggedUser!.uid,
                                reviewerName: (loggedUser!.firstName! + " " + loggedUser!.lastName!),
                                meisterUid: widget.work.meisterUid,
                                workItemUid: widget.work.uid,
                            )
                          )
                        );
                      },
                    ),
                SizedBox(height: AppMargins.S,),

              ]),
            ),
          ),
        ),
        SizedBox(height: AppMargins.M,),
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
        FutureBuilder(
          future: databaseService.getWorkItemReviews(widget.work.uid),
          builder: ((context, snapshot) {
          if (snapshot.hasData){
            List<Review>? reviewList = snapshot.data as List<Review>?;
            if (reviewList!.isNotEmpty){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: reviewList.length,
                itemBuilder: (BuildContext context, int index) {
                return ReviewTile(
                  name: reviewList[index].reviewerName,
                  rating: reviewList[index].rating,
                );
                }
              );
            }
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Aceasta lucrare nu are nici o recenzie momentan",
                style: TextStyle(
                  fontSize: AppFontSizes.L,
                  color: Colors.black)),
          );
        })),
      ])))),
    );
  }
}
