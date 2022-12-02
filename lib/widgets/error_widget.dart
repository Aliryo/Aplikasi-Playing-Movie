import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 50,
      ),
      children: [
        Container(
          width: 300,
          height: 300,
          margin: const EdgeInsets.only(bottom: 80),
          child: Lottie.asset('assets/nointernet.json'),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.arvo(fontSize: 18),
        ),
      ],
    );
  }
}
