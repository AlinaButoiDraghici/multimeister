import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/models/hive_user.dart';
import 'package:multimeister/models/review_model.dart';
import 'package:multimeister/models/work_model.dart';
import 'package:multimeister/screens/add_work_item_page.dart';
import 'package:multimeister/screens/edit_profile.dart';
import 'package:multimeister/services/auth.dart';
import 'package:multimeister/services/hive.dart';
import 'package:multimeister/ui_components/custom_app_bar.dart';
import 'package:multimeister/ui_components/custom_button.dart';
import 'package:multimeister/ui_components/review_tile.dart';
import 'package:multimeister/ui_components/ui_specs.dart';
import 'package:multimeister/ui_components/work_card.dart';

class ProfilePage extends StatefulWidget {
  final HiveUser user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  final loggedUser = HiveServices().getUserData();
  // dummy lists for now
  List<Review> reviewList = [
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3)
  ];
  List<Work> workList = [
    Work(
        meisterName: "Gigel Ion",
        meisterCity: "Timisoara",
        meisterPhone: "+40",
        rating: 3,
        price: 0,
        title: "Mese lucrate manual",
        meisterUid: "",
        uid: "",
        label: "Tamplarie",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    Work(
        meisterName: "Gigel Ion",
        meisterCity: "Timisoara",
        meisterPhone: "+40",
        meisterUid: "",
        uid: "",
        rating: 3,
        price: 0,
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
                (widget.user.firstName ?? "") +
                    " " +
                    (widget.user.lastName ?? ""),
                style: TextStyle(
                    fontSize: AppFontSizes.XXL, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: AppMargins.XS),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
              child: Text(
                  (widget.user.isMeister ?? false) ? "Meister" : "Client",
                  style: TextStyle(fontSize: AppFontSizes.XL)),
            ),
            SizedBox(height: AppMargins.XS),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
                  child: Text((widget.user.phone ?? ""),
                      style: TextStyle(fontSize: AppFontSizes.S)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppMargins.S),
                  child: Text((widget.user.city ?? ""),
                      style: TextStyle(fontSize: AppFontSizes.S)),
                )
              ],
            ),
            widget.user.uid == loggedUser!.uid
                ? Padding(
                    padding: EdgeInsets.all(AppMargins.M),
                    child:
                        // added sign out here for now
                        CustomButton(
                            isPrimary: false,
                            onPressed: () async {
                              await HiveServices().removeUserFromBox();
                              await _auth.signOut();
                              Navigator.popUntil(context,
                                  (Route<dynamic> route) => route.isFirst);
                            },
                            text: "Iesi din cont"),
                  )
                : Container(),
            Padding(
                padding: EdgeInsets.all(AppMargins.M),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.user.uid == loggedUser!.uid
                        ? CustomButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            },
                            text: "Editeaza profilul")
                        : CustomButton(onPressed: () {}, text: "Contacteaza"),
                    Visibility(
                      visible: (widget.user.isMeister ?? false),
                      child: Padding(
                        padding: EdgeInsets.only(left: AppMargins.M),
                        child: CustomButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddWorkItemPage()));
                            },
                            text: "Adauga lucrare"),
                      ),
                    ),
                  ],
                )),
            (widget.user.isMeister ?? false)
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
                              name: reviewList[index].reviewerName,
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
                              work: workList[index],
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
