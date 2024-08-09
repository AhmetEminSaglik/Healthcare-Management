class LineChartSideTitle {
  late int _index;
  late String _text;

  LineChartSideTitle({required int index, required String text}) {
    _index = index;
    _text = text;
  }

  String get text => _text;

  int get index => _index;

  @override
  String toString() {
    return 'LineChartSideTitle{_index: $_index, _text: $_text}';
  }
}
