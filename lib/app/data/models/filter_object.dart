class FilterObject {
  String name;
  dynamic value;

  FilterObject({required this.name, required this.value});

  @override
  bool operator ==(Object other) {
    return other is FilterObject && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}
