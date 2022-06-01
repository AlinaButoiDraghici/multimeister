import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multimeister/models/hive_user.dart';
import 'package:multimeister/screens/profile_page.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

class ReviewTile extends StatefulWidget {
  final String name;
  final double? rating;
  const ReviewTile(
      {Key? key,
      required this.name,
      this.rating})
      : super(key: key);

  @override
  State<ReviewTile> createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(AppMargins.S),
        child: Material(
          shadowColor: AppColors.DarkGray,
          elevation: 3,
          borderRadius: BorderRadius.circular(5),
          child: ListTile(
            contentPadding: EdgeInsets.all(AppMargins.S),
            tileColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.name,
                style: TextStyle(fontSize: AppFontSizes.M, color: Colors.black),
              ),
            ),
            leading: CircleAvatar(
              //TODO: add profile photo if it exists
              backgroundColor: AppColors.Yellow,
              foregroundColor: Colors.white,
              child: Text(widget.name[0]),
            ),
            trailing: SizedBox(
              width: 175,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RatingBar.builder(
                      itemCount: 5,
                      itemSize: 25,
                      initialRating: widget.rating ?? 0,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (rating) {}),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      // TODO: Add navigation...
                      // HiveUser hiveUser =???
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ProfilePage(
                      //             user: hiveUser!,
                      //           )),
                      //         );
                    }
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
