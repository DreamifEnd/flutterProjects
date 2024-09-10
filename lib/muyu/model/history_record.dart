class MeritRecord {
  final String id;
  final String image;
  final int value;
  final int dateTime;

  MeritRecord(
      {required this.id,
      required this.image,
      required this.value,
      required this.dateTime});

  @override
  String toString() {
    return 'MeritRecord{id: $id, image: $image, value: $value, dateTime: $dateTime}';
  }
}
