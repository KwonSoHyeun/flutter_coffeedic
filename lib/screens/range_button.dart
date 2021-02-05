import 'package:flutter/material.dart';

class CounterWithState {
  int _iCounter;
  RangeDemo _counterWithStateInternal;

  fnDataChanged(int iNewCounter) {
    _iCounter = iNewCounter;
    debugPrint("CounterWithState: New value = $_iCounter");
  }

  RangeDemo getCounterWidget() {
    return _counterWithStateInternal;
  }

  CounterWithState({@required iCounter}) {
    _iCounter = iCounter;
    _counterWithStateInternal = RangeDemo(this._iCounter, fnDataChanged);
  }
  get iCounter => _iCounter;
}

RangeButtonState pageState;

class RangeDemo extends StatefulWidget {
  final int iCounter;
  final Function fnDataChanged;

  RangeDemo(this.iCounter, this.fnDataChanged);

  @override
  RangeButtonState createState() {
    print("iCounter ======" + iCounter.toString());
    pageState = RangeButtonState();
    return pageState;
  }
}

class RangeButtonState extends State<RangeDemo> {
  int value = 0;

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _iCounter = 0;

  @override
  void initState() {
    super.initState();
    _iCounter = widget.iCounter;
    print("_iCounter ======" + _iCounter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  height: 5.0,
                  minWidth: 5.0,
                  onPressed: () {
                    setState(() {
                      _iCounter = 1;
                      widget.fnDataChanged(_iCounter);
                    });
                  },
                  color: (_iCounter >= 1) ? Colors.blue : Colors.white,
                  padding: EdgeInsets.all(6),
                  shape: CircleBorder(),
                ),
                MaterialButton(
                  height: 5.0,
                  minWidth: 5.0,
                  onPressed: () {
                    setState(() {
                      _iCounter = 2;
                      widget.fnDataChanged(_iCounter);
                    });
                  },
                  color: (_iCounter >= 2) ? Colors.blue : Colors.white,
                  padding: EdgeInsets.all(6),
                  shape: CircleBorder(),
                ),
                MaterialButton(
                  height: 5.0,
                  minWidth: 5.0,
                  onPressed: () {
                    setState(() {
                      _iCounter = 3;
                      widget.fnDataChanged(_iCounter);
                    });
                  },
                  color: (_iCounter >= 3) ? Colors.blue : Colors.white,
                  padding: EdgeInsets.all(6),
                  shape: CircleBorder(),
                ),
                MaterialButton(
                  height: 5.0,
                  minWidth: 5.0,
                  onPressed: () {
                    setState(() {
                      _iCounter = 4;
                      widget.fnDataChanged(_iCounter);
                    });
                  },
                  color: (_iCounter >= 4) ? Colors.blue : Colors.white,
                  padding: EdgeInsets.all(6),
                  shape: CircleBorder(),
                ),
                MaterialButton(
                  height: 5.0,
                  minWidth: 5.0,
                  onPressed: () {
                    setState(() {
                      _iCounter = 5;
                      widget.fnDataChanged(_iCounter);
                    });
                  },
                  color: (_iCounter >= 5) ? Colors.blue : Colors.white,
                  padding: EdgeInsets.all(6),
                  shape: CircleBorder(),
                )
              ],
            ),
          ],
        ));
  }

  int getValue() {
    return value;
  }
}
