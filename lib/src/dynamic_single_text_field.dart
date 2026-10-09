import 'package:dynamic_single_text_field/src/enums/show_labels_type_enum.dart';
import 'package:dynamic_single_text_field/src/models/single_text_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This class is the Dynamic Single Text Field and provide to developer different customizations
class DynamicSingleTextField extends StatefulWidget {
  ///ListView Section

  /// This parameter is the list of model for single text
  final List<SingleTextModel> singleTextModelList;

  /// This parameter is the option to set scroll physics for the ListView
  final ScrollPhysics? scrollPhysics;

  ///  This parameter is the option to set the scroll controller for the ListView
  final ScrollController? scrollController;

  ///  This parameter is the option to set the height of the dynamic ListView, with default value 150
  final double singleDynamicListHeight;

  ///Single Text Section

  /// This parameter is the option to set the height for the single texts, with default value 70
  final double singleTextHeight;

  /// This parameter is the option to set the width for the single texts, with default value 70
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

  /// This parameter is the option to set the input type for single texts, with default value text
  final TextInputType? textInputType;

  /// This parameter is the option to set the cursor color for single texts, with default value black
  final Color cursorColor;

  /// This parameter is the option to set if the single texts is read only, with default value false
  final bool isReadOnly;

  /// This parameter is the option to set if the single texts is obscure, with default value false
  final bool isObscureText;

  /// This parameter is the option to set the obscuring character for single texts, with default value •
  final String obscuringCharacter;

  /// This parameter is the option to set the fill color for single texts
  final Color? singleTextFillColor;

  /// listeners - call backs

  /// This parameter is the call back to get the character during the typing (real time) and the index of the single text
  final Function(String value, int index)? onChangeSingleText;

  /// This parameter is the call back to get the character when press the done/return button from the keyboard
  final Function(String value)? onSubmitSingleText;

  /// This parameter is the call back to validate the characters based on the length
  final Function? onValidationBaseOnLength;

  ///Labels Section

  /// This parameter is the enum class to set if need label on top or bottom or both, `showBottomLabelType`, `showBothLabelsType`, `hideLabelsType` default value: `hideLabelsType`
  final ShowLabelsTypeEnum showLabelsType;

  /// This parameter is the top label text style
  final TextStyle? textStyleTopLabel;

  /// This parameter is the bottom label text style
  final TextStyle? textStyleBottomLabel;

  /// This parameter is the single texts left margin, with default value 20
  final double widgetLeftMargin;

  /// This parameter is the top label text margin bottom, with default value 0
  final double topLabelMarginBottom;

  /// This parameter is the bottom label text margin top, with default value 0
  final double bottomLabelMarginTop;

  const DynamicSingleTextField({
    super.key,
    required this.singleTextModelList,
    this.scrollPhysics,
    this.scrollController,
    this.singleDynamicListHeight = 150,
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
  final List<TextEditingController> _textEditingControllerList = [];
  final List<FocusNode> _focusNodeList = [];

  /// This method is to get the single text as string
  String get _getSingleTextAsString =>
      widget.singleTextModelList.map((e) => e.singleText).join();

  @override
  void initState() {
    super.initState();
    // Create one controller and one focus node for each box.
    _syncControllers();
    // Put the prefilled text (SingleTextModel.singleText) into each box (see point 3).
    _syncTexts();
    // Register the backspace handler only once, here.
    // It is removed once, in dispose().
    HardwareKeyboard.instance.addHandler(_hardwareInputCallback);
  }

  /// This method is to make sure there is exactly one text editing controller
  /// and one focus node for each single text.
  /// It adds the missing ones and disposes the extra ones.
  Future<void> _syncControllers() async {
    final int length = widget.singleTextModelList.length;
    // Fewer controllers than boxes: add only the missing ones.
    // Example: 4 controllers and 6 boxes -> adds 2.
    while (_textEditingControllerList.length < length) {
      _textEditingControllerList.add(TextEditingController());
      _focusNodeList.add(FocusNode());
    }
    // More controllers than boxes: remove the extra ones from the end.
    // Example: 6 controllers and 4 boxes -> removes 2.
    while (_textEditingControllerList.length > length) {
      final TextEditingController controller =
          _textEditingControllerList.removeLast();
      final FocusNode focusNode = _focusNodeList.removeLast();
      // The removed text fields are still on screen until this frame ends,
      // so dispose them after the frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // The removed text fields are still on screen until this frame ends.
        // Disposing them now would crash, so dispose them after the frame.
        controller.dispose();
        focusNode.dispose();
      });
    }
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  /// Free every controller and focus node, because the widget is removed.
  Future<void> _dispose() async {
    for (final TextEditingController controller in _textEditingControllerList) {
      controller.dispose();
    }
    for (final FocusNode focusNode in _focusNodeList) {
      focusNode.dispose();
    }
    HardwareKeyboard.instance.removeHandler(_hardwareInputCallback);
  }

  /// This method is to handle the update widget for the dynamic list view.
  /// It runs every time the parent rebuilds this widget.
  @override
  void didUpdateWidget(covariant DynamicSingleTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Compare with the controllers we actually have, not with oldWidget.
    // If the user added a box to the SAME list and called setState,
    // oldWidget.singleTextModelList and widget.singleTextModelList are the
    // same object, so comparing their lengths would miss the change.
    _syncControllers();
    // Copy any changed prefilled text into the boxes (see point 3).
    _syncTexts();
  }

  /// This method is to handle the focus process
  /// @param index is the index of the single text
  void _focusProcess(int index) {
    if (widget.singleTextModelList[index].singleText.isEmpty && index != 0) {
      _focusNodeList[index].previousFocus();
    } else if (index != widget.singleTextModelList.length - 1 &&
        widget.singleTextModelList.first.singleText.isNotEmpty) {
      _focusNodeList[index].nextFocus();
    }
  }

  /// This method is to handle the hardware input callback
  /// @param event is the event for the hardware input
  bool _hardwareInputCallback(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      final int currentFocusIndex =
          _focusNodeList.indexWhere((node) => node.hasFocus);
      if (currentFocusIndex != -1 &&
          currentFocusIndex != 0 &&
          _textEditingControllerList[currentFocusIndex].text.isEmpty) {
        _focusNodeList[currentFocusIndex].previousFocus();
        return true;
      }
    }
    return false;
  }

  /// This method is to copy the text of each SingleTextModel into its box.
  /// It is called from initState() and didUpdateWidget(), never from build().
  Future<void> _syncTexts() async {
    for (int i = 0; i < widget.singleTextModelList.length; i++) {
      // The text the model says this box should have.
      final String text = widget.singleTextModelList[i].singleText;
      // The controller that shows this box's text.
      final TextEditingController controller = _textEditingControllerList[i];
      // Change it only when it is different. Setting the same text again
      // would move the cursor and interrupt the user while typing.
      if (controller.text != text) {
        controller.text = text;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.singleDynamicListHeight,
      width: double.infinity,
      child: ListView.builder(
        itemCount: widget.singleTextModelList.length,
        scrollDirection: Axis.horizontal,
        physics: widget.scrollPhysics,
        controller: widget.scrollController,
        itemBuilder: (context, index) {
          SingleTextModel singleTextModel = widget.singleTextModelList[index];
          return Column(
            children: [
              if (widget.showLabelsType ==
                      ShowLabelsTypeEnum.showTopLabelType ||
                  widget.showLabelsType ==
                      ShowLabelsTypeEnum.showBothLabelsType)
                _topLabel(singleTextModel),
              Flexible(
                child: _singleTextField(
                    singleTextModel,
                    _textEditingControllerList[index],
                    _focusNodeList[index],
                    index),
              ),
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

  /// This method is to handle the top label for the single text
  /// @param singleTextModel is the model for the single text
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

  /// This method is to handle the single text field
  /// @param singleTextModel is the model for the single text
  /// @param textEditingController is the text editing controller for the single text
  /// @param focusNode is the focus node for the single text
  /// @param index is the index of the single text
  Widget _singleTextField(
    SingleTextModel singleTextModel,
    TextEditingController textEditingController,
    FocusNode focusNode,
    int index,
  ) {
    return Container(
      height: widget.singleTextHeight,
      width: widget.singleTextWidth,
      margin: EdgeInsets.only(
        left: widget.widgetLeftMargin,
      ),
      child: TextField(
        key: Key(index.toString()),
        focusNode: focusNode,
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
                .every((element) => element.singleText.isNotEmpty)) {
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

  /// This method is to handle the bottom label for the single text
  /// @param singleTextModel is the model for the single text
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
