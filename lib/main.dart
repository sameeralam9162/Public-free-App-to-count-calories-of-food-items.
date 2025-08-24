import 'package:flutter/material.dart';

void main() {
  runApp(CaloriesCounterApp());
}

class CaloriesCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calories Counter',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _foodController = TextEditingController();
  final Map<String, int> foodCalories = {
    "Apple": 52,
    "Banana": 89,
    "Rice (1 cup)": 206,
    "Egg (1 boiled)": 78,
    "Milk (1 glass)": 150,
  };

  int totalCalories = 0;

  void addFood() {
    String food = _foodController.text.trim();
    if (foodCalories.containsKey(food)) {
      setState(() {
        totalCalories += foodCalories[food]!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$food added!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Food not found in database!")),
      );
    }
    _foodController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calories Counter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Total Calories: $totalCalories",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _foodController,
              decoration: InputDecoration(
                labelText: "Enter food name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addFood,
              child: Text("Add Food"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: foodCalories.entries.map((entry) {
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text("${entry.value} cal"),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}