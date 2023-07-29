import 'package:dynamic_single_text_field/src/models/show_labels_type_enum.dart';
import 'package:dynamic_single_text_field/src/models/single_text_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicSingleTextField extends StatefulWidget {
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
  InputBorder? enableInputBorder;
  InputBorder? disableInputBorder;
  InputBorder? focusedInputBorder;
  TextInputType? textInputType;
  Color cursorColor;
  bool isReadOnly;
  bool isObscureText;
  String obscuringCharacter;
  Color? singleTextFillColor;
  Function? onChangeSingleText;
  Function? onSubmitSingleText;
  Function? onValidationBaseOnLength;

  ///Labels
  ShowLabelsTypeEnum showLabelsType;
  TextStyle? textStyleTopLabel;
  TextStyle? textStyleBottomLabel;
  double widgetLeftMargin;
  double topLabelMarginBottom;
  double bottomLabelMarginTop;

  DynamicSingleTextField({
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
    this.enableInputBorder,
    this.disableInputBorder,
    this.focusedInputBorder,
    this.textInputType = TextInputType.text,
    this.cursorColor = Colors.black,
    this.isReadOnly = false,
    this.isObscureText = false,
    this.obscuringCharacter = "•",
    this.singleTextFillColor,
    this.onChangeSingleText,
    this.onSubmitSingleText,
    this.onValidationBaseOnLength,
    this.showLabelsType = ShowLabelsTypeEnum.hide_labels_type,
    this.textStyleTopLabel,
    this.textStyleBottomLabel,
    this.widgetLeftMargin = 20,
    this.topLabelMarginBottom = 0,
    this.bottomLabelMarginTop = 0,
  });

  @override
  State<DynamicSingleTextField> createState() => _DynamicSingleTextFieldState();
}

class _DynamicSingleTextFieldState extends State<DynamicSingleTextField> {
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
    return Expanded(
      child: ListView.builder(
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
              if (widget.showLabelsType ==
                      ShowLabelsTypeEnum.show_top_label_type ||
                  widget.showLabelsType ==
                      ShowLabelsTypeEnum.show_both_labels_type)
                _topLabel(singleTextModel),
              _singleTextField(singleTextModel, textEditingController, index),
              if (widget.showLabelsType ==
                      ShowLabelsTypeEnum.show_bottom_label_type ||
                  widget.showLabelsType ==
                      ShowLabelsTypeEnum.show_both_labels_type)
                _bottomLabel(singleTextModel),
            ],
          );
        },
      ),
    );
  }

  Widget _topLabel(SingleTextModel singleTextModel) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.widgetLeftMargin,
        bottom: widget.topLabelMarginBottom,
      ),
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
      ),
      child: TextField(
        controller: textEditingController,
        textAlign: TextAlign.center,
        keyboardType: widget.textInputType,
        cursorColor: widget.cursorColor,
        readOnly: widget.isReadOnly,
        obscureText: widget.isObscureText,
        obscuringCharacter: widget.obscuringCharacter,
        style: widget.textFieldTextStyle ?? const TextStyle(),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          fillColor: widget.singleTextFillColor,
          filled: widget.singleTextFillColor != null,
          border: widget.inputBorder ?? const UnderlineInputBorder(),
          focusedBorder:
              widget.focusedInputBorder ?? const UnderlineInputBorder(),
          disabledBorder:
              widget.disableInputBorder ?? const UnderlineInputBorder(),
          enabledBorder:
              widget.enableInputBorder ?? const UnderlineInputBorder(),
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
          if (widget.onValidationBaseOnLength != null) {
            if (widget.singleTextModelList
                .where((element) => element.singleText.isNotEmpty)
                .isNotEmpty) {
              widget.onValidationBaseOnLength!();
            }
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
          left: widget.widgetLeftMargin, top: widget.bottomLabelMarginTop),
      child: Text(
        singleTextModel.bottomLabelText ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: widget.textStyleBottomLabel ?? const TextStyle(),
      ),
    );
  }
}
