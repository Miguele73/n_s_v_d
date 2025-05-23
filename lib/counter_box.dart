import 'package:flutter/material.dart';
// import 'package:n_s_v_d/custom_button.dart';

class CounterBox extends StatefulWidget {
  final Color color;
  final void Function(int c) onChanged;

  const CounterBox({super.key, required this.color, required this.onChanged});

  @override
  State<CounterBox> createState() => _CounterBoxState();
}

class _CounterBoxState extends State<CounterBox> {
  // State
  // int _count = 0;
  int _characters = 0;

  // void _increment() {
  //   setState(() {
  //     _count++;
  //   });
  //   widget.onChanged(_count);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Zählerstand",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  // _count = int.tryParse(value) ?? 0;
                  _characters = value.length;
                });
                widget.onChanged(_characters);
              },
            ),
          ),
          //   onChanged: () {
          //     _increment();
          //   },
          //   text: "Klick!",
          // ),
          // Text("$_count"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("Anzahl Zeichen: $_characters")],
            ),
          ),
        ],
      ),
    );
  }
}
