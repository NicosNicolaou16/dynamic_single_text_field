import 'package:dynamic_single_text_field/dynamic_single_text_field.dart';
import 'package:dynamic_single_text_field/model/single_text_model.dart';
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
          height: MediaQuery.of(context).size.height / 2,
        ),
        Expanded(
            child: DynamicSingleTextFieldWidget(
          singleTextModelList: singleTextModelList,
          showLabelsType: ShowLabelsType.show_both_labels_type,
          textInputType: TextInputType.number,
        )),
      ],
    ));
  }
}
