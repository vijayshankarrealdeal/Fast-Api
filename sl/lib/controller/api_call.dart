import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sl/app/chart.dart';

enum SwitchOption { table, graph }

enum GraphList { pie, bar, scatter, line, histogram }

class APICalls extends ChangeNotifier {
  APICalls() {
    callTopRating();
  }
  SwitchOption defaultOption = SwitchOption.table;
  GraphList defaultGraph = GraphList.line;

  List<Map<String, dynamic>> firstData = [];
  List<Map<String, dynamic>> resutlData = [];
  TextEditingController controller = TextEditingController();
  bool load = false;
  void clearX() {
    resutlData.clear();
    notifyListeners();
  }

  void switchView(SwitchOption view) {
    defaultOption = view;
    notifyListeners();
  }

  void userSearchCall() async {
    load = true;
    notifyListeners();
    resutlData.clear();

    final url = Uri.parse("http://127.0.0.1:8000/query/${controller.text}");
    final response = await http.get(url);
    resutlData = List.from(json.decode(response.body));
    load = false;
    notifyListeners();
  }

  void callTopRating() async {
    final url = Uri.parse("http://127.0.0.1:8000/app/top_rating");
    final response = await http.get(url);
    firstData = List.from(json.decode(response.body));
    notifyListeners();
  }

  void switchgraph(GraphList graph) {
    defaultGraph = graph;
    notifyListeners();
  }

  Widget giveMeChart(List<Map<String, dynamic>> data) {
    if (defaultGraph == GraphList.bar) {
      return CartesianChartBarX(data: data);
    }
    if (defaultGraph == GraphList.pie) {
      return CartesianChartPieX(data: data);
    }
    if (defaultGraph == GraphList.scatter) {
      return CartesianChartScatterX(data: data);
    }
    if (defaultGraph == GraphList.histogram) {
      return CartesianChartHistogramX(data: data);
    }

    return CartesianChartLineX(data: data);
  }
}
