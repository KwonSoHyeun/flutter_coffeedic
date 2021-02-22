import 'package:flutter/material.dart';

/*
icon button 의 여백과 icon 의 여백이 사이즈가 다르다.
icon button 으로 구현한경우 여백이 너무 커서 예쁘게 표현되지 않음.
현재는 중간 정렬로 제공되는 공개 라이브러리 사용할 예정
*/
class ValueIconWidget {
  int _iCounter;
  //String _labelText;
  ValuePicker _valuepicker;
  bool _isreadonly = true;

  fnDataChanged(int iNewCounter) {
    _iCounter = iNewCounter;
    debugPrint("CounterWithState: New value = $_iCounter");
  }

  ValuePicker getValueIconWidget() {
    return _valuepicker;
  }

  ValueIconWidget(
      {@required lableText, @required iCounter, @required isReadOnly}) {
    _iCounter = iCounter;
    //_labelText = lableText;
    _isreadonly = isReadOnly;
    _valuepicker = ValuePicker(this._iCounter, fnDataChanged, this._isreadonly);
  }
  get iCounter => _iCounter;
}

ValuePickerState pageState;

class ValuePicker extends StatefulWidget {
  final int iCounter;
  //final String labelText;
  final Function fnDataChanged;
  final bool isReadOnly;

  ValuePicker(this.iCounter, this.fnDataChanged, this.isReadOnly);

  @override
  ValuePickerState createState() {
    //print("iCounter ======" + iCounter.toString());
    pageState = ValuePickerState();
    return pageState;
  }
}

class ValuePickerState extends State<ValuePicker> {
  int _iCounter = 0;
  bool _isreadonly;
  double _mydefaultsize = 30.0;

  @override
  void initState() {
    super.initState();
    _iCounter = widget.iCounter;
    _isreadonly = widget.isReadOnly;
    //_mydefaultsize = 50.0;
    print("_iCounter ======" + _iCounter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        child: Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  if (!_isreadonly)
                    setState(() {
                      _iCounter = 1;
                      widget.fnDataChanged(_iCounter);
                    });
                },
                icon: (_iCounter >= 1)
                    ? Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                iconSize: _mydefaultsize,
              ),
              IconButton(
                onPressed: () {
                  if (!_isreadonly)
                    setState(() {
                      _iCounter = 2;
                      widget.fnDataChanged(_iCounter);
                    });
                },
                icon: (_iCounter >= 2)
                    ? Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                iconSize: _mydefaultsize,
              ),
              IconButton(
                onPressed: () {
                  if (!_isreadonly)
                    setState(() {
                      _iCounter = 3;
                      widget.fnDataChanged(_iCounter);
                    });
                },
                icon: (_iCounter >= 3)
                    ? Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                iconSize: _mydefaultsize,
              ),
              IconButton(
                onPressed: () {
                  if (!_isreadonly)
                    setState(() {
                      _iCounter = 4;
                      widget.fnDataChanged(_iCounter);
                    });
                },
                icon: (_iCounter >= 4)
                    ? Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                iconSize: _mydefaultsize,
              ),
              IconButton(
                onPressed: () {
                  if (!_isreadonly)
                    setState(() {
                      _iCounter = 5;
                      widget.fnDataChanged(_iCounter);
                    });
                },
                icon: (_iCounter >= 5)
                    ? Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                iconSize: _mydefaultsize,
              ),

              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Icon(
                Icons.audiotrack,
                color: Colors.green,
                size: 30.0,
              ),
              Icon(
                Icons.beach_access,
                color: Colors.blue,
                size: 36.0,
              ),
              //Expanded(child: Text("test"))
            ],
          ),
        ));
  }

  int getValue() {
    return _iCounter;
  }
}
