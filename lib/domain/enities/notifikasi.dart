class NothifApp {
  final int id;
  final String title;
  final String body;
  final String? image;
  final String? payload;
   DateTime? time;

  NothifApp(
      {required this.id,
      this.time,
      required this.title,
      this.payload,
      required this.body,
      this.image});
}
