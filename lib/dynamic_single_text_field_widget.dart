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
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("top text"),
              ),
              Container(
                width: 70,
                height: 70,
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
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("bottom text"),
              ),
            ],
          );
        });
  }
}
