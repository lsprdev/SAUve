// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

class ClassesRepository {
  final allClasses = <List<String?>>[];
  getClass() async {
    final link = 'https://horarios.araquari.ifc.edu.br/data/horario2023-1_years_days_horizontal.html';
    final response = await http.get(Uri.parse(link));
    final document = parser.parse(response.body);

    final list = document.querySelector('ul');
    final elements= list?.querySelectorAll('li');


    if (elements != null) {
      for (final element in elements) {
        final text = element.querySelector('a')?.text;
        final href = element.querySelector('a')?.attributes['href'];

        final classData = [text, href];

        allClasses.add(classData);
      }
    } else {
      print('No elements found');
    }
  }
}