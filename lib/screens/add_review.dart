import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/models/review_model.dart';
import 'package:multimeister/models/work_model.dart';
import 'package:multimeister/ui_components/custom_button.dart';
import 'package:multimeister/ui_components/custom_carousel_slider.dart';
import 'package:uuid/uuid.dart';
import './home/home.dart';
import '../constants/string_constants.dart';
import '../services/database.dart';
import '../services/hive.dart';
import '../ui_components/custom_floating_button.dart';
import '../ui_components/custom_textfield.dart';
import '../ui_components/ui_specs.dart';

class AddReviewPage extends StatefulWidget {
  final String meisterUid;
  final String reviewerUid;
  final String workItemUid;
  final String reviewerName;
  final DatabaseService databaseService = DatabaseService();

  AddReviewPage({Key? key, required this.meisterUid, required this.reviewerUid, required this.workItemUid, required this.reviewerName}) : super(key: key);

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double _rating = 0;
  bool _showReviewError = false;
  final _reviewFormKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            SizedBox(height: AppMargins.L),
            Padding(
                padding: EdgeInsets.all(AppMargins.S),
                child: Text(
                  "Cat de multumit ai fost?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: AppFontSizes.XL),
                )),
            SizedBox(height: AppMargins.M),

            RatingBar.builder(
                          itemCount: 5,
                          itemSize: 40,
                          initialRating: 0, //rating ?? 0
                          ignoreGestures: false,
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {
                            _rating = rating;
                          }
                        ),
            SizedBox(height: AppMargins.L,),
            CustomButton(
              text: "Adauga",
              onPressed: () async {
                if (_rating == 0) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Review-ul trebuie sa aiba cel putin o stea!")));
                  return;
                }
                var uuid = Uuid();
            
                Review review = Review(
                  uid: uuid.v1(),
                  reviewerUid: widget.reviewerUid,
                  reviewerName: widget.reviewerName,
                  meisterUid: widget.meisterUid,
                  workItemUid: widget.workItemUid,
                  rating: _rating);
                
                String result = await widget.databaseService.addReview(review);
                if (result.contains("success")) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result)));
                }
              }
            )
          ]))),
    );
  }
}
