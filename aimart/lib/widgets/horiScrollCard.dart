import 'package:flutter/material.dart';

class HoriScrollCard extends StatelessWidget {
  const HoriScrollCard({
    Key? key,
    required this.title,
    required this.showingCount,
    required this.totalCategoryCount,
    required this.child,
    required this.onPressed,
    required this.color,
    required this.buttonName,
  }) : super(key: key);

  final String title;
  final int showingCount;
  final int totalCategoryCount;
  final Widget child;
  final void Function()? onPressed;
  final Color color;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showingCount != 0,
      child: Card(
        color: color,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            buildHeadingWithCount(title, showingCount, totalCategoryCount),
            child,
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: OutlinedButton(
                  child: Text(
                    buttonName,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromARGB(204, 54, 244, 212),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeadingWithCount(
      String title, int showingCount, int totalCategoryCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            "Showing $showingCount of $totalCategoryCount",
            style: TextStyle(fontSize: 9),
          ),
        ),
      ],
    );
  }
}
