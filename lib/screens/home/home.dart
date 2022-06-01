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
  // List<Review> reviewList = [
  //   Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
  //   Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3),
  //   Review(reviewerName: "Gica", area: "Tm", phone: "07", rating: 3)
  // ];
  // List<Work> workListDummy = [
  //   Work(
  //       meisterName: "Gigel Ion",
  //       meisterCity: "Timisoara",
  //       meisterPhone: "+40",
  //       rating: 3,
  //       reviewList: List.empty(),
  //       meisterUid: "",
  //       uid: "",
  //       title: "Mese lucrate manual",
  //       label: "Tamplarie",
  //       price: 0,
  //       description:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
  //   Work(
  //       meisterName: "Gigel Ion",
  //       meisterCity: "Timisoara",
  //       meisterPhone: "+40",
  //       rating: 3,
  //       reviewList: List.empty(),
  //       meisterUid: "",
  //       uid: "",
  //       title: "Mese lucrate manual",
  //       label: "Tamplarie",
  //       price: 0,
  //       description:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showSearch: true),
      body: FutureBuilder(
        future: databaseService.getAllWorks(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 100,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData) {
            List<Work> workItemList = snapshot.data;
            return SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: workItemList.length,
                              itemBuilder: (context, int index) {
                                return WorkCard(
                                  work: workItemList[index],
                                );
                              }),
                        ],
                      ),
                    )));
          } else {
            return Container(
              color: Colors.white,
              child: const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
