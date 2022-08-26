import 'package:escape_life/db/firebase/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../db/entities/escaperoom.dart';

class HeaderWithSearchBox extends StatefulWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
    this.escaperoomSearch,
    this.myController,
  }) : super(key: key);
  final TextEditingController myController;

  final List<Escaperoom> escaperoomSearch;
  final Size size;

  @override
  State<HeaderWithSearchBox> createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();
    final escaperooms = Provider.of<List<Escaperoom>>(context);

    return SizedBox(
      // It will cover 20% of our total height
      height: widget.size.height * 0.22,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            height: widget.size.height * 0.25 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 20,
            width: widget.size.width * 0.9,
            child: Text(
              "Tu buscador de Escape Rooms en España",
              style: GoogleFonts.ubuntu(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        dbService.setSearchParam(value, escaperooms);
                      },
                      controller: widget.myController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: GoogleFonts.ubuntu(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
