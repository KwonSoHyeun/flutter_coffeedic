import 'package:flutter/material.dart';

class ValuePickerWidget {
  int _iCounter;
  String _labelText;
  ValuePicker _valuepicker;

  fnDataChanged(int iNewCounter) {
    _iCounter = iNewCounter;
    debugPrint("CounterWithState: New value = $_iCounter");
  }

  ValuePicker getValuePickerWidget() {
    return _valuepicker;
  }

  ValuePickerWidget({@required lableText, @required iCounter}) {
    _iCounter = iCounter;
    _labelText = lableText;
    _valuepicker = ValuePicker(this._labelText, this._iCounter, fnDataChanged);
  }
  get iCounter => _iCounter;
}

ValuePickerState pageState;

class ValuePicker extends StatefulWidget {
  final int iCounter;
  final String labelText;
  final Function fnDataChanged;

  ValuePicker(this.labelText, this.iCounter, this.fnDataChanged);

  @override
  ValuePickerState createState() {
    //print("iCounter ======" + iCounter.toString());
    pageState = ValuePickerState();
    return pageState;
  }
}

class ValuePickerState extends State<ValuePicker> {
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
      margin: const EdgeInsets.only(bottom: 15.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Row(
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
        ),
      ),
    );
  }

/*
Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: Row(
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
    );
*/
  int getValue() {
    return _iCounter;
  }
}
