import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/models/review_model.dart';
import 'package:multimeister/models/work_model.dart';
import 'package:multimeister/ui_components/custom_app_bar.dart';
import 'package:multimeister/ui_components/custom_button.dart';
import 'package:multimeister/ui_components/review_tile.dart';
import 'package:multimeister/ui_components/ui_specs.dart';
import 'package:multimeister/ui_components/work_card.dart';

class ProfilePage extends StatefulWidget {
  final bool isMeister;
  const ProfilePage({Key? key, required this.isMeister}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // dummy lists for now
  List<Review> reviewList = [
    Review("Gica", "Tm", "07", 3),
    Review("Gica", "Tm", "07", 3),
    Review("Gica", "Tm", "07", 3)
  ];
  List<Work> workList = [
    Work(
        name: "Gigel Ion",
        area: "Timisoara",
        phone: "+40",
        rating: 3,
        title: "Mese lucrate manual",
        label: "Tamplarie",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    Work(
        name: "Gigel Ion",
        area: "Timisoara",
        phone: "+40",
        rating: 3,
        title: "Mese lucrate manual",
        label: "Tamplarie",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            SizedBox(height: AppMargins.M),
            const CircleAvatar(
              backgroundColor: AppColors.DarkGray,
              foregroundColor: Colors.white,
              radius: 50,
              // icon or photo
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            SizedBox(height: AppMargins.M),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
              child: Text(
                "NAME",
                style: TextStyle(
                    fontSize: AppFontSizes.XXL, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: AppMargins.XS),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
              child: Text("client/master",
                  style: TextStyle(fontSize: AppFontSizes.XL)),
            ),
            SizedBox(height: AppMargins.XS),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
                  child:
                      Text("+40", style: TextStyle(fontSize: AppFontSizes.S)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
                  child:
                      Text("area", style: TextStyle(fontSize: AppFontSizes.S)),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(AppMargins.M),
              child:
                  CustomButton(onPressed: () {}, text: "Contacteaza/editeaza"),
            ),
            widget.isMeister
                ? Column(
                    children: [
                      RatingBar.builder(
                          itemCount: 5,
                          itemSize: 40,
                          initialRating: 3, //rating ?? 0
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {}),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(AppMargins.S),
                          child: Text(
                            "Recenzii",
                            style: TextStyle(
                                fontSize: AppFontSizes.XL,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: reviewList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ReviewTile(
                              name: reviewList[index].name,
                              area: reviewList[index].area,
                              phone: reviewList[index].phone,
                              rating: reviewList[index].rating,
                            );
                          }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(AppMargins.S),
                          child: Text(
                            "Lucrari",
                            style: TextStyle(
                                fontSize: AppFontSizes.XL,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: workList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return WorkCard(
                              name: workList[index].name,
                              area: workList[index].area,
                              phone: workList[index].phone,
                              rating: workList[index].rating,
                              title: workList[index].title,
                              label: workList[index].label,
                              description: workList[index].description,
                            );
                          }),
                    ],
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }
}
