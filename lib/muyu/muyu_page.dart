import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test11/muyu/cout_panel.dart';
import 'package:test11/muyu/history_list_page.dart';
import 'package:test11/muyu/model/ImageOption.dart';
import 'package:test11/muyu/model/history_record.dart';
import 'package:uuid/uuid.dart';

import 'animate_text.dart';
import 'muyu_image.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  Random _random = Random();
  int _count = 0;
  int _curcount = 0;
  final List<ImageOption> imageoptions = const [
    ImageOption("基础版", "assets/images/muyu.png", 3, 1),
    ImageOption("豪华版", "assets/images/muyu2.png", 6, 3)
  ];
  int activeImageIndex = 0;
  AudioPool? pool;

  List<MeritRecord> _record = [];
  final Uuid uuid = Uuid();

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  void _initAudio() async {
    pool = await FlameAudio.createPool(
      "muyu_1.mp3",
      maxPlayers: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("电子木鱼"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(onPressed: _toHistory, icon: const Icon(Icons.history))
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: CountPanel(
            count: _count,
            onTopSwitchAudio: _onTopSwitchAudio,
            onTopSwitchImage: _onTopSwitchImage,
          )),
          Expanded(
              child: Stack(
            alignment: Alignment.topCenter,
            children: [
              MuyuImage(
                path: imPath,
                onTap: _onKnock,
              ),
              if (_curcount != 0) AnimateText(text: '功德+$_curcount')
            ],
          ))
        ],
      ),
    );
  }

  void _toHistory() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => HistoryListPage(record: _record)));
  }

  void _onTopSwitchAudio() {}

  void _onTopSwitchImage() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext) {
          return ImageOptionPanel(
            im: imageoptions,
            onSelect: onSelectImage,
            activeIndex: activeImageIndex,
          );
        });
  }

  void onSelectImage(int value) {
    Navigator.of(context).pop();
    if (value == activeImageIndex) return;
    setState(() {
      activeImageIndex = value;
    });
  }

  int get knockValue {
    int min = imageoptions[activeImageIndex].min;
    int max = imageoptions[activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  String get imPath {
    return imageoptions[activeImageIndex].src;
  }

  void _onKnock() {
    pool?.start();
    setState(() {
      _curcount = knockValue;
      _count += _curcount;

      String id = uuid.v4();
      _record.add(MeritRecord(
        id: id,
        image: imPath,
        value: _curcount,
        dateTime: DateTime.now().millisecondsSinceEpoch,
      ));
    });
    _record.forEach((item) {
      print(item);
    });
  }
}
