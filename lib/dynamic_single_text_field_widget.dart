import 'package:dynamic_single_text_field/model/single_text_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicSingleTextFieldWidget extends StatefulWidget {
  final List<SingleTextModel> singleTextModelList;
  double singleTextHeight;
  double singleTextWidth;
  ShowLabelType showLabelType;
  String singleHintText;
  TextStyle? singleHintTextStyle;
  InputBorder? inputBorder;
  TextStyle? textStyleTopLabel;
  TextStyle? textStyleBottomLabel;
  double leftMargin;

  DynamicSingleTextFieldWidget(
    this.singleTextModelList, {
    super.key,
    this.singleTextHeight = 70,
    this.singleTextWidth = 70,
    this.showLabelType = ShowLabelType.hide_labels_type,
    this.singleHintText = "",
    this.singleHintTextStyle,
    this.inputBorder,
    this.textStyleTopLabel,
    this.textStyleBottomLabel,
    this.leftMargin = 20,
  });

  @override
  State<DynamicSingleTextFieldWidget> createState() =>
      _DynamicSingleTextFieldWidgetState();
}

class _DynamicSingleTextFieldWidgetState
    extends State<DynamicSingleTextFieldWidget> {
  _focusProcess(int index) {
    if (widget.singleTextModelList[index].singleText.isEmpty && index != 0) {
      FocusScope.of(context).previousFocus();
    } else if (index != widget.singleTextModelList.length - 1 &&
        widget.singleTextModelList[0].singleText.isNotEmpty) {
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.singleTextModelList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          SingleTextModel singleTextModel = widget.singleTextModelList[index];
          TextEditingController textEditingController = TextEditingController();
          textEditingController.text = singleTextModel.singleText;
          return Column(
            children: [
              if (widget.showLabelType == ShowLabelType.show_top_label_type ||
                  widget.showLabelType == ShowLabelType.show_both_labels_type)
                Container(
                  margin: EdgeInsets.only(left: widget.leftMargin),
                  child: Text(
                    singleTextModel.topLabel ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: widget.textStyleTopLabel ?? const TextStyle(),
                  ),
                ),
              Container(
                height: widget.singleTextHeight,
                width: widget.singleTextWidth,
                margin: EdgeInsets.only(left: widget.leftMargin),
                child: TextField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                      border:
                          widget.inputBorder ?? const UnderlineInputBorder(),
                      hintText: widget.singleHintText,
                      hintStyle:
                          widget.singleHintTextStyle ?? const TextStyle()),
                  onChanged: (String value) {
                    widget.singleTextModelList[index].singleText = value;
                    _focusProcess(index);
                    String fullValue = widget.singleTextModelList
                        .map((e) => e.singleText)
                        .join();
                    if (kDebugMode) {
                      print(fullValue);
                    }
                  },
                ),
              ),
              if (widget.showLabelType ==
                      ShowLabelType.show_bottom_label_type ||
                  widget.showLabelType == ShowLabelType.show_both_labels_type)
                Container(
                  margin: EdgeInsets.only(left: widget.leftMargin),
                  child: Text(
                    singleTextModel.bottomLabel ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: widget.textStyleBottomLabel ?? const TextStyle(),
                  ),
                ),
            ],
          );
        });
  }
}

enum ShowLabelType {
  show_top_label_type,
  show_bottom_label_type,
  show_both_labels_type,
  hide_labels_type
}
