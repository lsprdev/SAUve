import 'package:flutter/material.dart';

import '../repositories/classes_repository.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {

  final _classesRepo = ClassesRepository();
  int _pageIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // _classesRepo.getClass();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    setState(() {
      _isLoading = true;
    });
    await _classesRepo.getClass();
    final classes = await _classesRepo.allClasses;
    print('krl: $classes');
    if (classes != null) {
      setState(() {
        _classes = classes;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  List<List<String?>> _classes = [];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true, 
        title: Text("Horário de Aulas", style: TextStyle(color: Colors.black)),
        elevation: 1, 
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(
            color: Colors.black, 
          ))
          : ListView.builder(
              itemCount: _pageIndex * 23 + 23,
              itemBuilder: (context, index) {
                if (index >= _classes.length) {
                  return null;
                }
                return ListTile(
                  title: Text('${_classes[index][0]}'),
                  subtitle: const Text("Matutino - Integral - Noturno"),
                  trailing: const Icon(Icons.push_pin_outlined),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _pageIndex++;
          });
        },
        child: const Icon(Icons.arrow_downward),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}