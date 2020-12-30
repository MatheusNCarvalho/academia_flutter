import 'package:flutter/material.dart';

class TimeComponent extends StatefulWidget {
  DateTime date;
  ValueChanged<DateTime> onSelectedTime;
  TimeComponent({
    Key key,
    this.date,
    this.onSelectedTime,
  }) : super(key: key);

  @override
  _TimeComponentState createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  final List<String> _hours = List.generate(24, (index) => index++)
      .map((h) => '${h.toString().padLeft(2, '0')}')
      .toList();

  final List<String> _min = List.generate(60, (index) => index++)
      .map((h) => '${h.toString().padLeft(2, '0')}')
      .toList();

  final List<String> _sec = List.generate(60, (index) => index++)
      .map((h) => '${h.toString().padLeft(2, '0')}')
      .toList();

  String _hourSelected = "00";
  String _minuteSelected = "00";
  String _secondSelected = "00";

  void invokeCallback() {
    var hours = int.parse(_hourSelected);
    var minute = int.parse(_minuteSelected);
    var second = int.parse(_secondSelected);

    var newDate = DateTime(
      widget.date.year,
      widget.date.month,
      widget.date.day,
      hours,
      minute,
      second,
    );

    widget.onSelectedTime(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBox(_hours, (value) => _onChangeItems(1, value)),
        _buildBox(_min, (value) => _onChangeItems(2, value)),
        _buildBox(_sec, (value) => _onChangeItems(3, value)),
      ],
    );
  }

  void _onChangeItems(int index, String value) {
    switch (index) {
      case 1:
        _hourSelected = value;
        break;
      case 2:
        _minuteSelected = value;
        break;
      case 3:
        _secondSelected = value;
    }
    invokeCallback();
  }

  Widget _buildBox(List<String> options, ValueChanged<String> onChange) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 10,
            color: Theme.of(context).primaryColor,
            offset: Offset(2, 5),
          )
        ],
      ),
      child: ListWheelScrollView(
        physics: FixedExtentScrollPhysics(),
        itemExtent: 60,
        perspective: 0.007,
        onSelectedItemChanged: (value) {
          onChange(value.toString().padLeft(2, '0'));
        },
        children: options.map(
          (item) {
            return Text(
              item,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
