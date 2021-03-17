import 'dart:io';

import 'package:flutter/material.dart';

import '../screens/home/home_details_page.dart';

class VerticalPlaceItem extends StatelessWidget {
  final Map coffeedata;

  VerticalPlaceItem({this.coffeedata});

  @override
  Widget build(BuildContext context) {
    //Locale myLocale = Localizations.localeOf(context);
    final String defaultLocale = Platform.localeName;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        child: Container(
          height: 70.0,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  "${coffeedata["image"]}",
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Image.asset(
                      "assets/default_coffee.jpeg",
                      height: 70.0,
                      width: 70.0,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(width: 15.0),
              Container(
                height: 80.0,
                width: MediaQuery.of(context).size.width - 130.0,
                child: ListView(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        defaultLocale == "ko_KR"
                            ? "${coffeedata["name"]}"
                            : "${coffeedata["name_en"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 13.0,
                          color: Colors.blueGrey[300],
                        ),
                        SizedBox(width: 3.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            defaultLocale == "ko_KR"
                                ? "${coffeedata["country"]}"
                                : "${coffeedata["country_en"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.blueGrey[300],
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        defaultLocale == "ko_KR"
                            ? "${coffeedata["desc"]}"
                            : "${coffeedata["desc_en"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Details(coffeedata);
              },
            ),
          );
        },
      ),
    );
  }
}
