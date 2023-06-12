import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  final String title, description;

  const Description(
      {super.key, required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Descriptipon'),
        ),
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                      fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  description,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  ),
                )),
          ],
        ));
  }
}
