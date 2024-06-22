/// This model is using to create the number of the single text boxes
class SingleTextModel {
  /// Text to show - prefilled
  String singleText;

  /// Top label text on top of the single text box
  String? topLabelText;

  /// Bottom label text on top of the single text box
  String? bottomLabelText;

  SingleTextModel({
    this.singleText = "",
    this.topLabelText,
    this.bottomLabelText,
  });
}
