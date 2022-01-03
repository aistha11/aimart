import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key? key,
    this.controller,
    required this.wait,
    required this.onTap,
    required this.buttonName,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool wait;
  final String buttonName;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      // decoration: BoxDecoration(
      //   color: Color(0xff1d1d1d),
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: TextFormField(
        controller: controller,
        // style: TextStyle(color: Colors.white, fontSize: 17),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: "Phone Number",
          hintStyle: TextStyle(color: Colors.black38, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+977) ",
              style: TextStyle(color: Colors.black87, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: onTap,
            // onTap: wait
            //     ? null
            //     : () async {
            //         setState(() {
            //           start = 30;
            //           wait = true;
            //           buttonName = "Resend";
            //         });
            // await authClass.verifyPhoneNumber(
            //     "+977 ${phoneController.text}", context, setData);
            //       },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
