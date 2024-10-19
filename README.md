## Features

This package is a dynamic single text field (it is like PIN/OTP code view but has not PIN/OTP
functionalities)
with top/bottom text label, and different customizations.

## Getting started

Version Minimum Flutter SDK: 3.0.0

Tested Versioning: <br />
Flutter SDK version: 3.24.3 <br />
Dart Version: 3.5.3 <br /> <br />

## Usage

| Parameters                 | Description                                                                                                                                                                                                      |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `singleTextModelList`      | This parameter is the list of model for single text. Important Note: Use this model to insert data into dynamic single text: `SingleTextModel({this.singleText = "", this.topLabelText, this.bottomLabelText});` |
| `scrollPhysics`            | This parameter is the option to set scroll physics for the ListView                                                                                                                                              |
| `scrollController`         | This parameter is the option to set the scroll controller for the ListView                                                                                                                                       |
| `singleDynamicListHeight`  | This parameter is the option to set the height of the dynamic ListView, with default value 150                                                                                                                   |
| `singleTextHeight`         | This parameter is the option to set the height for the single texts, with default value 70                                                                                                                       |
| `singleTextWidth`          | This parameter is the option to set the width for the single texts, with default value 70                                                                                                                        |
| `textFieldTextStyle`       | This parameter is the option to set the single texts style                                                                                                                                                       |
| `singleHintText`           | This parameter is the option to set the hint for the single texts                                                                                                                                                |
| `singleHintTextStyle`      | This parameter is the option to set the hint for single text style                                                                                                                                               |
| `inputBorder`              | This parameter is the option to set the input border for single texts                                                                                                                                            |
| `enableInputBorder`        | This parameter is the option to set the enable border for single texts                                                                                                                                           |
| `disableInputBorder`       | This parameter is the option to set the disable border for single texts                                                                                                                                          |
| `focusedInputBorder`       | This parameter is the option to set the focused border for single texts                                                                                                                                          |
| `textInputType`            | This parameter is the option to set the input type for single texts, with default value text                                                                                                                     |
| `cursorColor`              | This parameter is the option to set the cursor color for single texts, with default value black                                                                                                                  |
| `isReadOnly`               | This parameter is the option to set if the single texts is read only, with default value false                                                                                                                   |
| `isObscureText`            | This parameter is the option to set if the single texts is obscure, with default value false                                                                                                                     |
| `obscuringCharacter`       | This parameter is the option to set the obscuring character for single texts, with default value •                                                                                                               |
| `singleTextFillColor`      | This parameter is the option to set the fill color for single texts                                                                                                                                              |
| `onChangeSingleText`       | This parameter is the call back to get the character during the typing (real time) and the index of the single text                                                                                              |
| `onSubmitSingleText`       | This parameter is the call back to get the character when press the done/return button from the keyboard                                                                                                         |
| `onValidationBaseOnLength` | This parameter is the call back to validate the characters based on the length                                                                                                                                   |
| `showLabelsType`           | This parameter is the enum class to set if need label on top or bottom or both, `showBottomLabelType`, `showBothLabelsType`, `hideLabelsType` default value: `hideLabelsType`                                    |
| `textStyleTopLabel`        | This parameter is the top label text style                                                                                                                                                                       |
| `textStyleBottomLabel`     | This parameter is the bottom label text style                                                                                                                                                                    |
| `widgetLeftMargin`         | This parameter is the single texts left margin, with default value 20                                                                                                                                            |
| `topLabelMarginBottom`     | This parameter is the top label text margin bottom, with default value 0                                                                                                                                         |
| `bottomLabelMarginTop`     | This parameter is the bottom label text margin top, with default value 0                                                                                                                                         |

<p align="left">
<a title="simulator_image"><img src="https://github.com/NicosNicolaou16/dynamic_single_text_field/raw/main/screenshots/Screenshot_20240712_220940.png" height="500" width="200"></a>
<a title="simulator_image"><img src="https://github.com/NicosNicolaou16/dynamic_single_text_field/raw/main/screenshots/example_gif.gif" height="500" width="200"></a>
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            DynamicSingleTextField(
              singleTextModelList: singleTextModelList1,
              showLabelsType: ShowLabelsTypeEnum.hideLabelsType,
              inputBorder: getInputBorder(),
              singleDynamicListHeight: 70,
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
            const SizedBox(
              height: 100,
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
            const SizedBox(
              height: 100,
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
              onSubmitSingleText: (String value) {
                if (kDebugMode) {
                  print("value: $value");
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
      ),
    );
  }
}

```

## Additional information

Thank you for using my package, any feedback is welcome. You can report any bug, ask a question on
package GitHub repository.
https://github.com/NicosNicolaou16/dynamic_single_text_field/issues