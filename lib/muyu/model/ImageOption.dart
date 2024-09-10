import 'package:flutter/material.dart';

class ImageOption {
  final String name;
  final String src;
  final int min;
  final int max;

  const ImageOption(this.name, this.src, this.max, this.min);
}

class ImageOptionItem extends StatelessWidget {
  const ImageOptionItem(
      {super.key, required this.imageOption, required this.active});

  final ImageOption imageOption;
  final bool active;

  @override
  Widget build(BuildContext context) {
    const Border activeBorder =
        Border.fromBorderSide(BorderSide(color: Colors.blue));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: !active ? null : activeBorder,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(imageOption.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(imageOption.src),
            ),
          ),
          Text("每次功德+${imageOption.min}~${imageOption.max}",
              style: TextStyle(color: Colors.grey, fontSize: 12))
        ],
      ),
    );
  }
}

class ImageOptionPanel extends StatelessWidget {
  const ImageOptionPanel(
      {super.key,
      required this.im,
      required this.onSelect,
      required this.activeIndex});

  final List<ImageOption> im;

  final ValueChanged<int> onSelect;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              height: 46,
              alignment: Alignment.center,
              child: const Text(
                "选择木鱼",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Row(
                  children: [
                    Expanded(child: _buildByIndex(0)),
                    SizedBox(width: 10),
                    Expanded(child: _buildByIndex(1)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int i) {
    bool active = i == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(i),
      child: ImageOptionItem(imageOption: im[i], active: active),
    );
  }
}
