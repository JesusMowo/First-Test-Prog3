// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'dart:math';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  int counter = 0;
  void incrementCounter() {
    setState(() {
      if (counter < 3000) {
        counter++;
      }
    });
  }
  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }
  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }
  void timesTwoCounter() {
    setState(() {
      counter *= 2;
      if (counter > 3000) {
        counter = 3000;
      }
    });
  }
  void divideByTwoCounter() {
    setState(() {
      if (counter > 0) {
        counter ~/= 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height * 0.8;

    // area reservada para el texto central
    final double textAreaWidth = 180;
    final double textAreaHeight = 100;

    List<Widget> perritoImages = List.generate(counter, (index) {
      double top, left;

      // intenta hasta encontrar una posición fuera del area central
      int tries = 0;
      do {
        top = random.nextDouble() * (screenHeight - 60);
        left = random.nextDouble() * (screenWidth - 60);
        tries++;
      // Evita el area central
      } while (
        left + 60 > (screenWidth - textAreaWidth) / 2 &&
        left < (screenWidth + textAreaWidth) / 2 &&
        top + 60 > (screenHeight - textAreaHeight) / 2 &&
        top < (screenHeight + textAreaHeight) / 2 &&
        tries < 100
      );

      return Positioned(
        top: top,
        left: left,
        child: Image.asset(
          'assets/perrito.jpg',
          width: 60,
          height: 60,
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        title: const Text('Perrito App'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              ...perritoImages,
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: textAreaWidth,
                  height: textAreaHeight,
                  color: Colors.white.withOpacity(0.7), 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Perritos:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        '$counter',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColorLight,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Increment',
                onPressed: incrementCounter,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                tooltip: 'Decrement',
                onPressed: decrementCounter,
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset',
                onPressed: resetCounter,
              ),
              IconButton(
                icon: const Icon(Icons.call_made_outlined),
                tooltip: 'Times Two',
                onPressed: timesTwoCounter,
              ),
              IconButton(
                icon: const Icon(Icons.call_received),
                tooltip: 'Divide by Two',
                onPressed: divideByTwoCounter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}