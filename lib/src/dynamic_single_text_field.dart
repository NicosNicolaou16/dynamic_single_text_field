import 'package:dynamic_single_text_field/src/models/show_labels_type_enum.dart';
import 'package:dynamic_single_text_field/src/models/single_text_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicSingleTextField extends StatefulWidget {
  ///ListView Section

  /// This parameter is the list of model for single text
  final List<SingleTextModel> singleTextModelList;

  /// This parameter is the option to set scroll physics on ListView
  final ScrollPhysics? scrollPhysics;

  ///  This parameter is the option to set the scroll controller for the ListView
  final ScrollController? scrollController;

  ///Single Text Section

  /// This parameter is the option to set the height for the single texts
  final double singleTextHeight;

  /// This parameter is the option to set the width for the single texts
  final double singleTextWidth;

  /// This parameter is the option to set the single texts style
  final TextStyle? textFieldTextStyle;

  /// This parameter is the option to set the hint for the single texts
  final String singleHintText;

  /// This parameter is the option to set the hint for single text style
  final TextStyle? singleHintTextStyle;

  /// This parameter is the option to set the input border for single texts
  final InputBorder? inputBorder;

  /// This parameter is the option to set the enable border for single texts
  final InputBorder? enableInputBorder;

  /// This parameter is the option to set the disable border for single texts
  final InputBorder? disableInputBorder;

  /// This parameter is the option to set the focused border for single texts
  final InputBorder? focusedInputBorder;

  /// This parameter is the option to set the input type for single texts
  final TextInputType? textInputType;

  /// This parameter is the option to set the cursor color for single texts
  final Color cursorColor;

  /// This parameter is the option to set if the single texts is read only
  final bool isReadOnly;

  /// This parameter is the option to set if the single texts is obscure
  final bool isObscureText;

  /// This parameter is the option to set the obscuring character for single texts
  final String obscuringCharacter;

  /// This parameter is the option to set the fill color for single texts
  final Color? singleTextFillColor;

  /// listeners - call backs

  /// This parameter is the call back to get the character during the typing (real time)
  final Function? onChangeSingleText;

  /// This parameter is the call back to get the character when press the done/return button from the keyboard
  final Function? onSubmitSingleText;

  /// This parameter is the call back to validate the characters based on the length
  final Function? onValidationBaseOnLength;

  ///Labels
  final ShowLabelsTypeEnum showLabelsType;
  final TextStyle? textStyleTopLabel;
  final TextStyle? textStyleBottomLabel;
  final double widgetLeftMargin;
  final double topLabelMarginBottom;
  final double bottomLabelMarginTop;

  const DynamicSingleTextField({
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
    this.showLabelsType = ShowLabelsTypeEnum.hideLabelsType,
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
                      ShowLabelsTypeEnum.showTopLabelType ||
                  widget.showLabelsType ==
                      ShowLabelsTypeEnum.showBothLabelsType)
                _topLabel(singleTextModel),
              _singleTextField(singleTextModel, textEditingController, index),
              if (widget.showLabelsType ==
                      ShowLabelsTypeEnum.showBottomLabelType ||
                  widget.showLabelsType ==
                      ShowLabelsTypeEnum.showBothLabelsType)
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
