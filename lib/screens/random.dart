import 'package:flutter/material.dart';

class Random extends StatefulWidget {
  const Random({super.key});

  @override
  RandomState createState() => RandomState();
}

class RandomState extends State<Random> {
  List<TextEditingController> controllers =
      List.generate(10, (index) => TextEditingController());
  List<String> teamA = [];
  List<String> teamB = [];

  void _generateTeams() {
    List<String> allPlayers = controllers
        .map((c) => c.text)
        .where((text) => text.isNotEmpty)
        .toList();
    if (allPlayers.length == 10) {
      allPlayers.shuffle();
      teamA = allPlayers.sublist(0, 5);
      teamB = allPlayers.sublist(5);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Teams'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: teamA
                          .map(
                            (p) => Text(
                              p,
                              style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 20,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  if (teamA.isNotEmpty)
                    const Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Expanded(
                      child: Column(
                          children: teamB
                              .map(
                                (p) => Text(
                                  p,
                                  style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: 20,
                                  ),
                                ),
                              )
                              .toList())),
                ],
              ),
              const SizedBox(height: 16),
              ...List.generate(
                10,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controllers[index],
                    decoration:
                        InputDecoration(labelText: 'Player ${index + 1}'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _generateTeams,
                child: const Text('Generate Teams'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Random Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
