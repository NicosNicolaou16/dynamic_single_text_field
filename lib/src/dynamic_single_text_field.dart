import 'dart:math' as math;
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

  /// This parameter is the option to set autofill hints for the single texts.
  /// Use `[AutofillHints.oneTimeCode]` so the keyboard suggests SMS codes.
  final Iterable<String>? autofillHints;

  /// This parameter is the option to set if the single texts is obscure, with default value false
  final bool isObscureText;

  /// This parameter is the option to set the obscuring character for single texts, with default value •
  final String obscuringCharacter;

  /// This parameter is the option to set the fill color for single texts
  final Color? singleTextFillColor;

  /// listeners - call backs

  /// This parameter is the call back to get the whole text (all single texts
  /// joined) during the typing (real time) and the index of the single text
  /// that changed.
  final void Function(String value, int index)? onChangeSingleText;

  /// This parameter is the call back to get the whole text (all single texts
  /// joined) when press the done/return button from the keyboard.
  final ValueChanged<String>? onSubmitSingleText;

  /// This parameter is the call back to validate the characters based on the length
  final VoidCallback? onValidationBaseOnLength;

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
    this.autofillHints,
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

  /// This getter is true when every single text has a character.
  bool get _isComplete => widget.singleTextModelList
      .every((element) => element.singleText.isNotEmpty);

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

  /// This method is to handle the focus process after a box changes:
  /// move to the next box after typing, or to the previous box after deleting.
  /// @param index is the index of the single text
  void _focusProcess(int index) {
    final bool isEmpty = widget.singleTextModelList[index].singleText.isEmpty;
    if (isEmpty && index > 0) {
      // The box was cleared: go back one box.
      _moveFocusTo(index - 1);
    } else if (!isEmpty && index < widget.singleTextModelList.length - 1) {
      // The box got a character: go forward one box.
      _moveFocusTo(index + 1);
    }
  }

  /// This method is to move the focus to the box at [index].
  /// It waits until the current frame is finished, so the keyboard has
  /// finished delivering the character to THIS box before the focus moves.
  /// Otherwise the keyboard can send the same character again to the next box.
  /// @param index is the index of the single text to focus
  void _moveFocusTo(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // The widget may be gone, or the box removed, by the time this runs.
      if (mounted && index < _focusNodeList.length) {
        // Focus exactly this box, by index, instead of nextFocus()/previousFocus(),
        // which follow Flutter's focus order and can skip a box.
        _focusNodeList[index].requestFocus();
      }
    });
    // Make sure a frame is coming, so the callback above actually runs.
    WidgetsBinding.instance.ensureVisualUpdate();
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
        // Go back exactly one box, by index (same as _focusProcess),
        // instead of previousFocus(), which can skip a box.
        _moveFocusTo(currentFocusIndex - 1);
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

  /// This method is called when the text of one single text changes.
  /// The value can be more than one character when the user types over a
  /// filled box, pastes a code, or uses SMS autofill.
  /// @param value is the new text of that single text
  /// @param index is the index of the single text
  void _onSingleTextChanged(String value, int index) {
    // The character this box had before the change ("" if it was empty).
    final String oldText = widget.singleTextModelList[index].singleText;
    // Remember if the code was already complete BEFORE this change, so the
    // "all filled" callback is only called when it BECOMES complete.
    final bool wasComplete = _isComplete;

    // Work out what the user ADDED.
    // Empty box:  value is exactly what was added (e.g. "5" or "123456").
    // Filled box: the old character is still in value, next to the new one.
    String inserted = value;
    if (oldText.isNotEmpty && value.length > oldText.length) {
      inserted = value.startsWith(oldText)
          // Cursor was after the old character: "5" + "7" = "57" -> added "7".
          ? value.substring(oldText.length)
          // Cursor was before the old character: "7" + "5" = "75" -> added "7".
          : value.substring(0, value.length - oldText.length);
    }

    // The last box already has a character and the user typed one more:
    // keep the old character and ignore the new one (there is no next box
    // to move to, so otherwise every keystroke would replace it again).
    final bool isLastBox = index == widget.singleTextModelList.length - 1;
    if (isLastBox && oldText.isNotEmpty && inserted.length == 1) {
      // Put the old character back in the text field ("57" -> "5").
      _setSingleText(index, oldText);
      // Nothing changed, so no callbacks.
      return;
    }

    if (inserted.length > 1) {
      // More than one character arrived: a paste or an SMS autofill.
      // Put one character in each box, starting from this box.
      _fillFrom(index, inserted);
    } else {
      // One character (typing / typing over a filled box) or "" (delete).
      _setSingleText(index, inserted);
      // Move to the next box after typing, or the previous one after deleting.
      _focusProcess(index);
    }

    // Tell the developer about the change.
    _notifyChanged(index, wasComplete);
  }

  /// This method is to put one character in each box, starting at [start].
  /// Characters that do not fit (more characters than boxes left) are ignored.
  /// @param start is the index of the first box to fill
  /// @param text is the pasted or autofilled text
  void _fillFrom(int start, String text) {
    // How many boxes we can fill: the length of the text, but never past
    // the last box. Example: 6 boxes, start at box 4 (index 3), "123456"
    // -> only 3 boxes are left, so count = 3.
    final int count =
        math.min(text.length, widget.singleTextModelList.length - start);
    for (int i = 0; i < count; i++) {
      _setSingleText(start + i, text[i]);
    }
    // Focus the box AFTER the last filled one, so the user can keep typing.
    // If the paste reached the last box, stay on the last box.
    _moveFocusTo(
        math.min(start + count, widget.singleTextModelList.length - 1));
  }

  /// This method is to set the text of one box, in both its model and its
  /// text field, so they always match.
  /// @param index is the index of the single text
  /// @param text is the new text (one character, or "" to clear the box)
  void _setSingleText(int index, String text) {
    // Keep the model updated, as before, because users read their values from it.
    widget.singleTextModelList[index].singleText = text;
    final TextEditingController controller = _textEditingControllerList[index];
    // Update the text field only when needed (for example it shows "57"
    // but should show "7"), and put the cursor after the character.
    if (controller.text != text) {
      controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  /// This method is to call the developer's callbacks after a change.
  /// @param index is the index of the single text that changed
  /// @param wasComplete is true if every box was already filled before the change
  void _notifyChanged(int index, bool wasComplete) {
    // Send the whole text (all boxes joined) and the box that changed.
    if (widget.onChangeSingleText != null) {
      widget.onChangeSingleText!(_getSingleTextAsString, index);
    }
    // Call the "all filled" callback only when the code BECOMES complete.
    // If it was already complete (for example the user typed over a middle
    // box), do not call it again.
    if (widget.onValidationBaseOnLength != null &&
        !wasComplete &&
        _isComplete) {
      widget.onValidationBaseOnLength!();
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
        autofillHints: widget.autofillHints,
        obscureText: widget.isObscureText,
        obscuringCharacter: widget.obscuringCharacter,
        style: widget.textFieldTextStyle ?? const TextStyle(),
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
          _onSingleTextChanged(value, index);
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
