import 'package:flutter/material.dart';

class Homeboxwidget extends StatelessWidget {
  final String txtTitle;
  final VoidCallback onTapCall;
  const Homeboxwidget({
    super.key,
    required this.txtTitle,
    required this.onTapCall,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapCall(),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 8),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        color: Color(0xffCCCCCC),
        child: Column(
          children: [
            Text(
              txtTitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xff8c1818),
              ),
            ),
            Container(
              width: double.infinity,
              height: 6,
              color: Color(0xff8c1818),
            ),
          ],
        ),
      ),
    );
  }
}
