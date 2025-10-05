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
  final List<SingleTextModel> _singleTextModelList1 = [];
  final List<SingleTextModel> _singleTextModelList2 = [];
  final List<SingleTextModel> _singleTextModelList3 = [];

  @override
  void initState() {
    ///
    /// Initializing three list with the SingleTextModel
    ///
    List.generate(
        7,
        (index) => _singleTextModelList1.add(SingleTextModel(
              singleText: "",
            )));
    List.generate(
        7,
        (index) => _singleTextModelList2.add(SingleTextModel(
            singleText: "",
            topLabelText: "top label $index",
            bottomLabelText: "bottom label $index")));
    List.generate(
        7,
        (index) => _singleTextModelList3.add(SingleTextModel(
            singleText: "",
            topLabelText: "top label $index",
            bottomLabelText: "bottom label $index")));
    super.initState();
  }

  InputBorder getInputBorder() => const OutlineInputBorder(
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
              singleTextModelList: _singleTextModelList1,
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
              singleTextModelList: _singleTextModelList2,
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
              singleTextModelList: _singleTextModelList3,
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
