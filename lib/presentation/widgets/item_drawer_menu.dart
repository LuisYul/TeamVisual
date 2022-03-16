import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDrawerMenu extends StatelessWidget {
  const ItemDrawerMenu({
    Key? key,
    required this.title,
    this.icon,
    this.onClick,
  }) : super(key: key);

  final String title;
  final IconData? icon;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Material(
        color: const Color(0xDAF2F8FD),
        elevation: 0.5,
        borderRadius: BorderRadius.circular(25.0),
        child: ListTile(
            title: Text(
              title,
              style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.blueGrey.shade800,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500
              ),
            ),
            leading: Icon(
              icon,
              color: Colors.blueGrey.shade900,
            ),
            trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.blueGrey.shade800,
            ),
            onTap: () => onClick!()
        ),
      ),
    );
  }
}
