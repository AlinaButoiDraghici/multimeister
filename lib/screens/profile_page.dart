import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/models/hive_user.dart';
import 'package:multimeister/models/review_model.dart';
import 'package:multimeister/models/work_model.dart';
import 'package:multimeister/screens/add_work_item_page.dart';
import 'package:multimeister/screens/edit_profile.dart';
import 'package:multimeister/services/auth.dart';
import 'package:multimeister/services/database.dart';
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
  final HiveUser? loggedUser = HiveServices().getUserData();
  final DatabaseService databaseService = DatabaseService();


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
                                          builder: (context) => EditProfile()))
                                  .then((value) => setState(() {}));
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
                      FutureBuilder(
                        future: databaseService.getMeisterScore(widget.user.meisterID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData){
                            double? rating = snapshot.data as double?;
                            return Column(
                              children: [
                                SizedBox(height:10),
                                Text("Rating meister: " + rating!.toStringAsFixed(2) + "/5",
                                  style: TextStyle(
                                      fontSize: AppFontSizes.XL, color: Colors.black)),
                                SizedBox(height:10),
                                RatingBar.builder(
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 40,
                                    initialRating: rating,
                                    ignoreGestures: true,
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (rating) {}),
                              ],
                            );
                          }
                          return RatingBar.builder(
                                itemCount: 5,
                                itemSize: 40,
                                initialRating: 0,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {}
                              );
                        }
                      ),
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
                      FutureBuilder(
                        future: databaseService.getMeisterWorks(widget.user.meisterID),
                        builder: ((context, snapshot) {
                        if (snapshot.hasData){
                          List<Work>? workList = snapshot.data as List<Work>?;
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: workList!.length,
                            itemBuilder: (BuildContext context, int index) {
                            return WorkCard(
                                work: workList[index],
                              );
                            }
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Aceast meserias nu are nici o lucrare",
                              style: TextStyle(
                                fontSize: AppFontSizes.L,
                                color: Colors.black)),
                        );
                      })),
                    ],
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }
}
