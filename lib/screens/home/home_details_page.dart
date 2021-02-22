import 'package:flutter/material.dart';
import 'package:coffeedic/util/places.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//import 'package:coffeedic/widgets/range_icon.dart';

class Details extends StatefulWidget {
  final Map coffeedata;
  const Details(this.coffeedata);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    //print(coffeedata.toString());
    //print("sweet" + coffeedata["sweet"].toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications_none,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          buildSlider(),
          SizedBox(height: 20),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.coffeedata["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.blueGrey[300],
                  ),
                  SizedBox(width: 3),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.coffeedata["country"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.blueGrey[300],
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.coffeedata["city"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.coffeedata["desc"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20.0),
              buildRangeIcon("Aroma", widget.coffeedata["aroma"].toDouble()),
              buildRangeIcon("Body", widget.coffeedata["body"].toDouble()),
              buildRangeIcon("Sweet", widget.coffeedata["sweet"].toDouble()),
              buildRangeIcon(
                  "Acidity", widget.coffeedata["acidity"].toDouble()),
              buildRangeIcon(
                  "Bitterness", widget.coffeedata["bitterness"].toDouble()),
              buildRangeIcon("Balance", widget.coffeedata["balance"].toDouble())
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.airplanemode_active,
        ),
        onPressed: () {},
      ),
    );
  }

  buildRangeIcon(String label, double initvalue) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: RatingBarIndicator(
              rating: initvalue,
              itemCount: 5,
              itemSize: 30.0,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // buildRangeIcon(String label, double initvalue) {
  //   return Column(
  //     children: [
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         padding: const EdgeInsets.only(bottom: 8),
  //         child: Text(
  //           label,
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 16,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         padding: const EdgeInsets.only(bottom: 8),
  //         child: RatingBarIndicator(
  //           rating: initvalue,
  //           itemCount: 5,
  //           itemSize: 30.0,
  //           physics: BouncingScrollPhysics(),
  //           itemBuilder: (context, _) => Icon(
  //             Icons.star,
  //             color: Colors.amber,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  buildSlider() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        //itemCount: places == null ? 0 : places.length,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "${widget.coffeedata["image"]}",
                height: 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
