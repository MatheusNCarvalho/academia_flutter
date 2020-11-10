import 'package:flutter/material.dart';

class TimeComponent extends StatefulWidget {
  @override
  _TimeComponentState createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  final List<String> _hours = List.generate(25, (index) => index++)
      .map((h) => '${h.toString().padLeft(2, '0')}')
      .toList();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildBox(_hours),
      ],
    );
  }

  Widget _buildBox(List<String> hours) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}
