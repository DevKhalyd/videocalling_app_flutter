void main(List<String> args) {
  final map = <String, dynamic>{
    'key': 1,
  };

  if (map.containsKey('key')) {
    print('key is in the map');
  }

  if (!map.containsValue('key2')) {
    print('kEY2 DOES NOT EXITS IN THE map');
  }
}
