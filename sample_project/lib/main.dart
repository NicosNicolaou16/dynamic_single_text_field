import 'package:dynamic_single_text_field/dynamic_single_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final List<SingleTextModel> singleTextModelList = [];

  @override
  void initState() {
    List.generate(
        7,
        (index) => singleTextModelList.add(SingleTextModel(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Expanded(
            child: DynamicSingleTextField(
              singleTextModelList: singleTextModelList,
              showLabelsType: ShowLabelsType.show_both_labels_type,
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
            ),
          ),
        ],
      ),
    );
  }
}
