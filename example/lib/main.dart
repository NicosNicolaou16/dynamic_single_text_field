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

            const Divider(),

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
