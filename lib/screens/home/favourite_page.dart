import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:rating_bar/rating_bar.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "원두 취향 \n찾아 보시겠어요?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("원두 취향 찾기"),
          ),
          buildListTile("aroma"),
          buildListTile("body"),
          buildListTile("sweet"),
          buildListTile("acidity"),
          buildListTile("bitter"),
          buildListTile("balance"),
        ],
      ),
    );
  }

  buildListTile(String label) {
    return ListTile(
        //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
        leading: Switch(
          value: false,
          onChanged: (value) {},
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
        title: buildRangeIcon(label, 0));
  }

  buildRangeIcon(String label, double initvalue) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: RatingBar(
            initialRating: initvalue,
            isHalfAllowed: false,
            halfFilledIcon: Icons.star_half,
            filledIcon: Icons.star,
            filledColor: Colors.amber,
            emptyIcon: Icons.star_border,
            size: 25,
            onRatingChanged: (double rating) {},
          ),
        ),
      ],
    );
  }
}
