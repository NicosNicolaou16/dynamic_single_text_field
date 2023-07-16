# dynamic_single_text_field

This library is a dynamic single text field (as PIN code) with different customization and top/bottom labels.

```dart

final List<SingleTextModel> singleTextModelList = [
  SingleTextModel(
    "",
    topLabelText: "top1",
    bottomLabelText: "bottom1",
  ),
  SingleTextModel(
    "",
    topLabelText: "top2",
    bottomLabelText: "bottom2",
  ),
  SingleTextModel(
    "",
    topLabelText: "top3",
    bottomLabelText: "bottom3",
  ),
  SingleTextModel(
    "",
    topLabelText: "top4",
    bottomLabelText: "bottom4",
  ),
  SingleTextModel(
    "",
    topLabelText: "top5",
    bottomLabelText: "bottom5",
  ),
  SingleTextModel(
    "",
    topLabelText: "top6",
    bottomLabelText: "bottom6",
  ),
];

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
            child: DynamicSingleTextFieldWidget(
              singleTextModelList: singleTextModelList,
              showLabelsType: ShowLabelsType.show_both_labels_type,
              inputBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
              ),
              textInputType: TextInputType.number,
              onChangeSingleText: (String value, int index) {
                if (kDebugMode) {
                  print("value: $value index: $index");
                }
              },
            ),
          ),
        ],
      ));
}
```