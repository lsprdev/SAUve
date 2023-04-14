// ignore_for_file: unnecessary_null_comparison

import 'package:auto_captive/views/widgets/classes_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late bool isPinned;
  List<List<String?>> _classes = [];
  List<String> pinnedItems = [];

  @override
  void initState() {
    super.initState();
    isPinned = false;
    _loadClasses();
    SharedPreferences.getInstance().then((prefs) {
      pinnedItems = prefs.getStringList('pinnedItems') ?? [];
    });
  }

  Future<void> _loadClasses() async {
    setState(() {
      _isLoading = true;
    });
    await _classesRepo.getClass();
    final classes = _classesRepo.allClasses;
    if (classes != null) {
      setState(() {
        _classes = classes;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true, 
        title: const Text("Horário de Aulas", style: TextStyle(color: Colors.black)),
        elevation: 1, 
        backgroundColor: Colors.white,
        centerTitle: false,
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
                
                  return ClassesTile(
                    title: _classes[index][0], 
                    table: _classes[index][1], 
                    classes: _classes[index],
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