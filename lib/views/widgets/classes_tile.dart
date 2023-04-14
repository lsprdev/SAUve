import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClassesTile extends StatefulWidget {
  final String? title;
  final String? table;
  List<String?> classes;

  ClassesTile({
    super.key,
    required this.title,
    required this.table,
    required this.classes,
  });

  @override
  State<ClassesTile> createState() => _ClassesTileState();
}

class _ClassesTileState extends State<ClassesTile> {
  bool? isPinned;
  List<String> pinnedItems = [];

  @override
  void initState() {
    super.initState();
    isPinned = false;
    SharedPreferences.getInstance().then((prefs) {
      pinnedItems = prefs.getStringList('pinnedItems') ?? [];
      if (pinnedItems.contains(widget.title)) {
        setState(() {
          isPinned = true;
        });
      }
    });
  }

  Future<void> savePinToSharedPrefs(String title) async {
    final prefs = await SharedPreferences.getInstance();
    pinnedItems = prefs.getStringList('pinnedItems') ?? [];
    if (!pinnedItems.contains(title) && pinnedItems.length < 3) {
      pinnedItems.add(title);
      await prefs.setStringList('pinnedItems', pinnedItems);
    }
    print(pinnedItems);
}

  Future<void> deletePinFromSharedPrefs(String title) async {
    final prefs = await SharedPreferences.getInstance();
    pinnedItems = prefs.getStringList('pinnedItems') ?? [];
    if (pinnedItems.contains(title)) {
      pinnedItems.remove(title);
      await prefs.setStringList('pinnedItems', pinnedItems);
    }
    print(pinnedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
          onTap: () async {
            await launchUrlString("https://horarios.araquari.ifc.edu.br/data/horario2023-1_years_days_horizontal.html${widget.table}");
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          subtitle: const Text("Clique para ver o horário completo."),
          title: Text(widget.title!),
          trailing: GestureDetector(
            onTap: () async {
              setState(() {
                isPinned = !isPinned!;
                isPinned == true ? savePinToSharedPrefs(widget.title!) : deletePinFromSharedPrefs(widget.title!);
              });
            },
            child: isPinned == true
                ? const Icon(
                    Icons.push_pin,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.push_pin_outlined,
                    color: Colors.black,
                  ),
          )
        ),
      
    );
  }
}