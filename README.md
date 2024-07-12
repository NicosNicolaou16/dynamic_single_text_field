## Features

This library is a dynamic single text field (it is like PIN code but has not PIN functionalities)
with top/bottom text label, and different customizations.

## Getting started

Version Minimum Flutter SDK: 3.0.0

Tested Versioning: <br />
Flutter SDK version: 3.22.2 <br />
Dart Version: 3.4.3 <br /> <br />

## Usage

| Parameters                 | Description                                                                                                                                                                                    |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `singleTextModelList`      | the list of model for single text. Important Note: Use this model to insert data into dynamic single text: `SingleTextModel({this.singleText = "", this.topLabelText, this.bottomLabelText});` |
| `scrollPhysics`            | scroll physics for the ListView                                                                                                                                                                |
| `scrollController`         | scroll controller for the ListView                                                                                                                                                             |
| `singleTextHeight`         | the height for the single texts, with default value 70                                                                                                                                         |
| `singleTextWidth`          | the width for the single texts, with default value 70                                                                                                                                          |
| `textFieldTextStyle`       | single text style                                                                                                                                                                              |
| `singleHintText`           | single hint text                                                                                                                                                                               |
| `singleHintTextStyle`      | single hint text style                                                                                                                                                                         |
| `inputBorder`              | input border for single texts                                                                                                                                                                  |
| `enableInputBorder`        | enable border for single texts                                                                                                                                                                 |
| `disableInputBorder`       | disable border for single texts                                                                                                                                                                |
| `focusedInputBorder`       | focused border for single texts                                                                                                                                                                |
| `textInputType`            | the input type for single texts, with default value text                                                                                                                                       |
| `cursorColor`              | the cursor color for single texts, with default value black                                                                                                                                    |
| `isReadOnly`               | if the single texts is read only, with default value false                                                                                                                                     |
| `isObscureText`            | the single texts is obscure, with default value false                                                                                                                                          |
| `obscuringCharacter`       | the obscuring character for single texts, with default value •                                                                                                                                 |
| `singleTextFillColor`      | the fill color for single texts                                                                                                                                                                |
| `onChangeSingleText`       | the call back to get the character during the typing (real time)                                                                                                                               |
| `onSubmitSingleText`       | the call back to get the character when press the done/return button from the keyboard                                                                                                         |
| `onValidationBaseOnLength` | the call back to validate the characters based on the length                                                                                                                                   |
| `showLabelsType`           | label types to show the text for `showTopLabelType`, `showBottomLabelType`, `showBothLabelsType`, `hideLabelsType` default value: `hideLabelsType`                                             |
| `textStyleTopLabel`        | the top label text style                                                                                                                                                                       |
| `textStyleBottomLabel`     | the bottom label text style                                                                                                                                                                    |
| `widgetLeftMargin`         | the single texts left margin, with default value 20                                                                                                                                            |
| `topLabelMarginBottom`     | the top label text margin bottom, with default value 0                                                                                                                                         |
| `bottomLabelMarginTop`     | the bottom label text margin top, with default value 0                                                                                                                                         |

<p align="left">
<a title="simulator_image"><img src="https://github.com/NicosNicolaou16/dynamic_single_text_field/raw/main/sample_project/lib/example_screenshots/Screenshot_20240712_220940.png" height="500" width="200"></a>
<a title="simulator_image"><img src="https://github.com/NicosNicolaou16/dynamic_single_text_field/raw/main/sample_project/lib/example_screenshots/example_gif.gif" height="500" width="200"></a>
</p>

```dart
import 'package:dynamic_single_text_field/dynamic_single_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<SingleTextModel> singleTextModelList1 = [];
  final List<SingleTextModel> singleTextModelList2 = [];
  final List<SingleTextModel> singleTextModelList3 = [];

  @override
  void initState() {
    List.generate(
        7,
            (index) =>
            singleTextModelList1.add(SingleTextModel(
              singleText: "",
            )));
    List.generate(
        7,
            (index) =>
            singleTextModelList2.add(SingleTextModel(
                singleText: "",
                topLabelText: "top label $index",
                bottomLabelText: "bottom label $index")));
    List.generate(
        7,
            (index) =>
            singleTextModelList3.add(SingleTextModel(
                singleText: "",
                topLabelText: "top label $index",
                bottomLabelText: "bottom label $index")));
    super.initState();
  }

  InputBorder getInputBorder() =>
      const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
          width: 3,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            70,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          DynamicSingleTextField(
            singleTextModelList: singleTextModelList1,
            showLabelsType: ShowLabelsTypeEnum.hideLabelsType,
            inputBorder: getInputBorder(),
            topLabelMarginBottom: 20,
            bottomLabelMarginTop: 20,
            enableInputBorder: getInputBorder(),
            disableInputBorder: getInputBorder(),
            focusedInputBorder: getInputBorder(),
            textInputType: TextInputType.number,
            onChangeSingleText: (String value, int index) {
              if (kDebugMode) {
                print("value: $value index: $index");
              }
            },
            onValidationBaseOnLength: () {
              if (kDebugMode) {
                print("validated");
              }
            },
          ),
          DynamicSingleTextField(
            singleTextModelList: singleTextModelList2,
            showLabelsType: ShowLabelsTypeEnum.showBothLabelsType,
            inputBorder: getInputBorder(),
            topLabelMarginBottom: 20,
            bottomLabelMarginTop: 20,
            enableInputBorder: getInputBorder(),
            disableInputBorder: getInputBorder(),
            focusedInputBorder: getInputBorder(),
            textInputType: TextInputType.number,
            onChangeSingleText: (String value, int index) {
              if (kDebugMode) {
                print("value: $value index: $index");
              }
            },
            onValidationBaseOnLength: () {
              if (kDebugMode) {
                print("validated");
              }
            },
          ),
          DynamicSingleTextField(
            singleTextModelList: singleTextModelList3,
            showLabelsType: ShowLabelsTypeEnum.showBothLabelsType,
            inputBorder: getInputBorder(),
            topLabelMarginBottom: 20,
            bottomLabelMarginTop: 20,
            textInputType: TextInputType.text,
            onChangeSingleText: (String value, int index) {
              if (kDebugMode) {
                print("value: $value index: $index");
              }
            },
            onValidationBaseOnLength: () {
              if (kDebugMode) {
                print("validated");
              }
            },
          ),
        ],
      ),
    );
  }
}

```

## Additional information

Thank you for using my package, any feedback is welcome. You can report any bug, ask a question on
package GitHub repository.
https://github.com/NicosNicolaou16/dynamic_single_text_field/issues