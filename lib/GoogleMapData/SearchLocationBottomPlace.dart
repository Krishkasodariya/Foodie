import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchLocationBottomPlace extends StatefulWidget {
  const SearchLocationBottomPlace({super.key,required this.location, required this.press});
  final String location;
  final VoidCallback press;
  @override
  State<SearchLocationBottomPlace> createState() => _SearchLocationBottomPlaceState();
}

class _SearchLocationBottomPlaceState extends State<SearchLocationBottomPlace> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: widget.press,
          horizontalTitleGap: 0,
          leading: Icon(
            Icons.location_on_rounded,
            color: Color(0xffEF505F),
            size: 25,
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.location,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Color(0xff313848),
                  fontWeight: FontWeight.w600),
            ),
          ),

        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Color(0xffEAEDF3), width: 1.5))),
          ),
        ),
      ],
    );
  }
}
