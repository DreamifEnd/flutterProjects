import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'guess_appbar.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});

  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  int _num = 0;
  final Random _random = Random();
  bool _guess = true;
  final TextEditingController _controller = TextEditingController();
  bool? _isBig;

  void _incrementCounter() {
    setState(() {
      _num = _random.nextInt(100);
      _guess = !_guess;
    });
  }

  void _onCheck() {
    int? guess = int.tryParse(_controller.text);
    if (_guess || guess == null) return;
    print("${_guess} ${guess} ${_num}");
    if (guess == _num) {
      setState(() {
        _isBig = null;
      });
      _guess = !_guess;

      // TODO
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: '猜对了',
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      setState(() {
        _isBig = guess > _num;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(
        onCheck: _onCheck,
        controller: _controller,
      ),
      body: Stack(children: [
        if (_isBig != null)
          Column(
            children: [
              if (_isBig!) ResultTipView(color: Colors.red, info: "大了"),
              Spacer(),
              if (!_isBig!) ResultTipView(color: Colors.blue, info: "小了"),
            ],
          ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_guess)
                const Text(
                  '点击右下角图标生成随机数值',
                ),
              Text(
                _guess ? '$_num' : '**',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _guess ? _incrementCounter : null,
        backgroundColor: _guess ? Colors.blue : Colors.grey,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ResultTipView extends StatefulWidget {
  Color color;
  String info;

  ResultTipView({super.key, required this.color, required this.info});

  @override
  State<ResultTipView> createState() => _ResultTipViewState();
}

class _ResultTipViewState extends State<ResultTipView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    controller.forward(from: 0);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          alignment: Alignment.center,
          color: widget.color,
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, child) => Text(
              widget.info,
              style: TextStyle(
                fontSize: 54 * (controller.value),
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
