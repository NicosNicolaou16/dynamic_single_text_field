## Features

This package is a dynamic single text field allows for the dynamic creation of multiple text fields
based on the developer's needs (similar to OTP/passcode inputs, but without the OTP/passcode
functionality—only the UI is provided).
You can create a list of `SingleTextModel` instances, each representing a single text field. Each
`SingleTextModel` can be customized with values such as preset characters,
and additional text displayed under the field. Each `SingleTextModel` accepts a single input
character.

## Getting started

Version Minimum Flutter SDK: 3.0.0

Tested Versioning: <br />
Flutter SDK version: 3.41.5 <br />
Dart Version: 3.11.3 <br /> <br />

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
      title: 'Dynamic Single Text Field Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Use descriptive names for your models to show intent
  final List<SingleTextModel> _otpCodeList = [];
  final List<SingleTextModel> _recoveryPhraseList = [];
  final List<SingleTextModel> _customStyledList = [];

  @override
  void initState() {
    super.initState();

    // 1. Initialize for a 6-digit OTP code (No labels needed)
    _otpCodeList.addAll(List.generate(
      6,
          (index) => SingleTextModel(singleText: ""),
    ));

    // 2. Initialize for a seed phrase (e.g., crypto wallet) with top and bottom labels
    _recoveryPhraseList.addAll(List.generate(
      5,
          (index) => SingleTextModel(
        singleText: "",
        topLabelText: "Word ${index + 1}",
        bottomLabelText: "Required",
      ),
    ));

    // 3. Initialize for a custom styled serial key
    _customStyledList.addAll(List.generate(
      4,
          (index) => SingleTextModel(singleText: ""),
    ));
  }

  /// Helper to create a unified rounded border for our custom example
  InputBorder _getCustomBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2.5),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    );
  }

  /// Helper to show a snackbar when an action occurs
  void _showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Single Text Field'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==========================================
            // EXAMPLE 1: OTP / PIN Verification
            // ==========================================
            _buildSectionHeader(
              title: "1. OTP / PIN Verification",
              description: "6 digits, numeric keyboard, hidden labels.",
            ),
            DynamicSingleTextField(
              singleTextModelList: _otpCodeList,
              showLabelsType: ShowLabelsTypeEnum.hideLabelsType,
              textInputType: TextInputType.number,
              onChangeSingleText: (String value, int index) {
                if (kDebugMode) print("OTP changed: $value at $index");
              },
              onValidationBaseOnLength: () {
                _showMessage("OTP Code completely filled!");
              },
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // ==========================================
            // EXAMPLE 2: Recovery / Seed Phrase
            // ==========================================
            _buildSectionHeader(
              title: "2. Recovery Phrase",
              description: "Text keyboard, top & bottom labels visible.",
            ),
            DynamicSingleTextField(
              singleTextModelList: _recoveryPhraseList,
              showLabelsType: ShowLabelsTypeEnum.showBothLabelsType,
              textInputType: TextInputType.text,
              topLabelMarginBottom: 10,
              bottomLabelMarginTop: 10,
              onChangeSingleText: (String value, int index) {
                if (kDebugMode) print("Word ${index + 1} typed: $value");
              },
              onSubmitSingleText: (String value) {
                _showMessage("Submitted phrase: $value");
              },
              onValidationBaseOnLength: () {
                _showMessage("All words entered successfully!");
              },
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // ==========================================
            // EXAMPLE 3: Custom Themed Input
            // ==========================================
            _buildSectionHeader(
              title: "3. Custom Styled Inputs",
              description: "Custom borders, colors, and heights.",
            ),
            DynamicSingleTextField(
              singleTextModelList: _customStyledList,
              showLabelsType: ShowLabelsTypeEnum.hideLabelsType,
              singleDynamicListHeight: 65,
              textInputType: TextInputType.text,
              // Setup custom borders for different states
              enableInputBorder: _getCustomBorder(color: Colors.grey.shade400),
              focusedInputBorder: _getCustomBorder(color: Colors.deepPurple),
              disableInputBorder: _getCustomBorder(color: Colors.grey.shade200),
              onChangeSingleText: (String value, int index) {},
              onValidationBaseOnLength: () {
                _showMessage("Custom form validated!");
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Reusable UI widget to separate examples clearly
  Widget _buildSectionHeader(
      {required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}


```

## Additional information

Thank you for using **dynamic_single_text_field**! Your feedback helps make this package better.
If you encounter any bugs or unexpected behavior, please open an issue on
the [GitHub repository](https://github.com/NicosNicolaou16/dynamic_single_text_field/issues).