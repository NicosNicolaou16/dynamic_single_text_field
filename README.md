# dynamic_single_text_field

This library is a dynamic single text field (like PIN code - has not PIN functionalities) with
different customization and top/bottom labels.

```dart

final List<SingleTextModel> singleTextModelList = [
  SingleTextModel(
    singleText: "",
    topLabelText: "top1",
    bottomLabelText: "bottom1",
  ),
  SingleTextModel(
    singleText: "",
    topLabelText: "top2",
    bottomLabelText: "bottom2",
  ),
  SingleTextModel(
    singleText: "",
    topLabelText: "top3",
    bottomLabelText: "bottom3",
  ),
  SingleTextModel(
    singleText: "",
    topLabelText: "top4",
    bottomLabelText: "bottom4",
  ),
  SingleTextModel(
    singleText: "",
    topLabelText: "top5",
    bottomLabelText: "bottom5",
  ),
  SingleTextModel(
    singleText: "",
    topLabelText: "top6",
    bottomLabelText: "bottom6",
  ),
];

InputBorder getInputBorder() =>
    const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          50,
        ),
      ),
    );

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height / 3,
        ),
        Expanded(
          child: DynamicSingleTextField(
            singleTextModelList: singleTextModelList,
            showLabelsType: ShowLabelsType.show_both_labels_type,
            inputBorder: getInputBorder(),
            enableInputBorder: getInputBorder(),
            disableInputBorder: getInputBorder(),
            focusedInputBorder: getInputBorder(),
            textInputType: TextInputType.number,
            onChangeSingleText: (String value, int index) {
              if (kDebugMode) {
                print("value: $value index: $index");
              }
            },
          ),
        ),
      ],
    ),
  );
}
```