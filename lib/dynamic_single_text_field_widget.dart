import 'package:dynamic_single_text_field/model/single_text_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicSingleTextFieldWidget extends StatefulWidget {
  ///ListView
  final List<SingleTextModel> singleTextModelList;
  ScrollPhysics? scrollPhysics;
  ScrollController? scrollController;

  ///Single Text
  double singleTextHeight;
  double singleTextWidth;
  TextStyle? textFieldTextStyle;
  String singleHintText;
  TextStyle? singleHintTextStyle;
  InputBorder? inputBorder;
  TextInputType? textInputType;
  Color cursorColor;
  bool isReadOnly;
  bool isObscureText;
  Color? singleTextFillColor;
  Function? onChangeSingleText;
  Function? onSubmitSingleText;

  ///Labels
  ShowLabelsType showLabelsType;
  TextStyle? textStyleTopLabel;
  TextStyle? textStyleBottomLabel;
  double widgetLeftMargin;
  double topLabelMarginTop;
  double bottomLabelMarginBottom;

  DynamicSingleTextFieldWidget({
    super.key,
    required this.singleTextModelList,
    this.scrollPhysics,
    this.scrollController,
    this.singleTextHeight = 70,
    this.singleTextWidth = 70,
    this.textFieldTextStyle,
    this.singleHintText = "",
    this.singleHintTextStyle,
    this.inputBorder,
    this.textInputType = TextInputType.text,
    this.cursorColor = Colors.black,
    this.isReadOnly = false,
    this.isObscureText = false,
    this.singleTextFillColor,
    this.onChangeSingleText,
    this.onSubmitSingleText,
    this.showLabelsType = ShowLabelsType.hide_labels_type,
    this.textStyleTopLabel,
    this.textStyleBottomLabel,
    this.widgetLeftMargin = 20,
    this.topLabelMarginTop = 0,
    this.bottomLabelMarginBottom = 0,
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
        widget.singleTextModelList.first.singleText.isNotEmpty) {
      FocusScope.of(context).nextFocus();
    }
  }

  String get _getSingleTextAsString =>
      widget.singleTextModelList.map((e) => e.singleText).join();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.singleTextModelList.length,
        scrollDirection: Axis.horizontal,
        physics: widget.scrollPhysics,
        controller: widget.scrollController,
        itemBuilder: (context, index) {
          SingleTextModel singleTextModel = widget.singleTextModelList[index];
          TextEditingController textEditingController = TextEditingController();
          textEditingController.text = singleTextModel.singleText;
          return Column(
            children: [
              if (widget.showLabelsType == ShowLabelsType.show_top_label_type ||
                  widget.showLabelsType == ShowLabelsType.show_both_labels_type)
                _topLabel(singleTextModel),
              _singleTextField(singleTextModel, textEditingController, index),
              if (widget.showLabelsType ==
                      ShowLabelsType.show_bottom_label_type ||
                  widget.showLabelsType == ShowLabelsType.show_both_labels_type)
                _bottomLabel(singleTextModel),
            ],
          );
        });
  }

  Widget _topLabel(SingleTextModel singleTextModel) {
    return Container(
      margin: EdgeInsets.only(left: widget.widgetLeftMargin),
      child: Text(
        singleTextModel.topLabelText ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: widget.textStyleTopLabel ?? const TextStyle(),
      ),
    );
  }

  Widget _singleTextField(SingleTextModel singleTextModel,
      TextEditingController textEditingController, int index) {
    return Container(
      height: widget.singleTextHeight,
      width: widget.singleTextWidth,
      margin: EdgeInsets.only(
        left: widget.widgetLeftMargin,
        top: widget.topLabelMarginTop,
      ),
      child: TextField(
        controller: textEditingController,
        textAlign: TextAlign.center,
        keyboardType: widget.textInputType,
        cursorColor: widget.cursorColor,
        readOnly: widget.isReadOnly,
        obscureText: widget.isObscureText,
        style: widget.textFieldTextStyle ?? const TextStyle(),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          fillColor: widget.singleTextFillColor,
          filled: widget.singleTextFillColor != null,
          border: widget.inputBorder ?? const UnderlineInputBorder(),
          focusedBorder: widget.inputBorder ?? const UnderlineInputBorder(),
          hintText: widget.singleHintText,
          hintStyle: widget.singleHintTextStyle ?? const TextStyle(),
        ),
        onChanged: (String value) {
          widget.singleTextModelList[index].singleText = value;
          _focusProcess(index);
          if (widget.onChangeSingleText != null) {
            String singleTextAsString = _getSingleTextAsString;
            widget.onChangeSingleText!(singleTextAsString, index);
          }
        },
        onSubmitted: (String value) {
          if (widget.onSubmitSingleText != null) {
            String singleTextAsString = _getSingleTextAsString;
            widget.onSubmitSingleText!(singleTextAsString);
          }
        },
      ),
    );
  }

  Widget _bottomLabel(SingleTextModel singleTextModel) {
    return Container(
      margin: EdgeInsets.only(
          left: widget.widgetLeftMargin,
          bottom: widget.bottomLabelMarginBottom),
      child: Text(
        singleTextModel.bottomLabelText ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: widget.textStyleBottomLabel ?? const TextStyle(),
      ),
    );
  }
}

enum ShowLabelsType {
  show_top_label_type,
  show_bottom_label_type,
  show_both_labels_type,
  hide_labels_type
}
