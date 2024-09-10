import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test11/muyu/model/history_record.dart';

DateFormat format = DateFormat('yyyy年MM月dd日 HH:mm:ss');

class HistoryListPage extends StatelessWidget {
  const HistoryListPage({super.key, required this.record});

  final List<MeritRecord> record;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: record.length,
      ),
    );
  }

  _buildAppbar() => AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "功德记录",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      );

  Widget? _buildItem(BuildContext context, int index) {
    MeritRecord merit = record[index];
    String date =
        format.format(DateTime.fromMillisecondsSinceEpoch(merit.dateTime));
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(merit.image),
      ),
      title: Text('功德 +${merit.value}'),
      trailing: Text(
        date,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
