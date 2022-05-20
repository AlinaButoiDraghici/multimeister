import 'package:flutter/material.dart';
import 'package:multimeister/services/database.dart';
import 'package:multimeister/ui_components/custom_app_bar.dart';
import 'package:multimeister/ui_components/work_card.dart';
import '../../models/review_model.dart';
import '../../models/work_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseService databaseService = DatabaseService();
  // dummy lists for now
  List<Review> reviewList = [
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
    Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3)
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
      appBar: const CustomAppBar(showSearch: true),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: workList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WorkCard(
                          work: workList[index],
                        );
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
