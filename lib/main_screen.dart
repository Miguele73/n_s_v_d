import 'package:flutter/material.dart';
import 'package:n_s_v_d/counter_box.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int box1 = 0;
  int box2 = 0;
  int box3 = 0;

  int get _totalCount => box1 + box2 + box3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 128, 32.0, 0),
        child: Center(
          child: Column(
            spacing: 16,
            children: [
              CounterBox(
                color: Colors.blue,
                onChanged: (c) {
                  setState(() {
                    box1 = c;
                  });
                },
              ),
              CounterBox(
                color: Colors.indigo,
                onChanged: (c) {
                  setState(() {
                    box2 = c;
                  });
                },
              ),
              CounterBox(
                color: Colors.purpleAccent,
                onChanged: (c) {
                  setState(() {
                    box3;
                  });
                },
              ),
              Text("Summe aller Längen: $_totalCount"),
            ],
          ),
        ),
      ),
    );
  }
}
