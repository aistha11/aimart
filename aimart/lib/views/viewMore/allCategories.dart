import 'package:aimart/config/config.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            AppHeader(heading: "All Categories"),
            SizedBox(
              height: 30,
            ),
            
          ],
        ),
      ),
    );
  }
}
