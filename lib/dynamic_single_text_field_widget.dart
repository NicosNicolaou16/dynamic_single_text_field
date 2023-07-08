import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DynamicSingleTextFieldWidget extends StatefulWidget {
  int itemCount;

  DynamicSingleTextFieldWidget({super.key, this.itemCount = 3});

  @override
  State<DynamicSingleTextFieldWidget> createState() =>
      _DynamicSingleTextFieldWidgetState();
}

class _DynamicSingleTextFieldWidgetState
    extends State<DynamicSingleTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 70,
            height: 150,
            margin: EdgeInsets.only(left: 20),
            child: TextField(
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "h",
              ),
            ),
          );
        });
  }
}
