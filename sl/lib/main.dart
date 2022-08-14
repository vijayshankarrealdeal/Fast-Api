import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sl/app/table_ui.dart';
import 'package:sl/controller/api_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _buildTheme(brightness) {
      var baseTheme = ThemeData(brightness: brightness);

      return baseTheme.copyWith(
        textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => APICalls()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.dark),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 6),
        child: Consumer<APICalls>(builder: (context, data, _) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CupertinoTheme(
                      data:
                          const CupertinoThemeData(brightness: Brightness.dark),
                      child: CupertinoSearchTextField(
                        controller: data.controller,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                      onPressed: () => data.userSearchCall(),
                      child: const Text("Search"))
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: data.load
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            data.defaultOption == SwitchOption.graph
                                ? Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            data.switchgraph(GraphList.line),
                                        icon: const Icon(Icons.line_axis),
                                        color: CupertinoColors.white,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            data.switchgraph(GraphList.pie),
                                        icon: const Icon(
                                            CupertinoIcons.chart_pie),
                                        color: CupertinoColors.white,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            data.switchgraph(GraphList.bar),
                                        icon: const Icon(Icons.bar_chart_sharp),
                                        color: CupertinoColors.white,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            data.switchgraph(GraphList.scatter),
                                        icon: const Icon(Icons.scatter_plot),
                                        color: CupertinoColors.white,
                                      ),
                                      IconButton(
                                        onPressed: () => data
                                            .switchgraph(GraphList.histogram),
                                        icon: const Icon(
                                            CupertinoIcons.chart_bar),
                                        color: CupertinoColors.white,
                                      ),
                                    ],
                                  )
                                : TextButton(
                                    onPressed: () =>
                                        data.switchView(SwitchOption.table),
                                    child: Icon(
                                      CupertinoIcons.table,
                                      color: data.defaultOption ==
                                              SwitchOption.table
                                          ? CupertinoColors.activeBlue
                                          : CupertinoColors.systemGrey,
                                    ),
                                  ),
                            TextButton(
                              onPressed: () =>
                                  data.switchView(SwitchOption.graph),
                              child: Icon(
                                CupertinoIcons.graph_square,
                                color: data.defaultOption == SwitchOption.graph
                                    ? CupertinoColors.activeBlue
                                    : CupertinoColors.systemGrey,
                              ),
                            ),
                            data.defaultOption == SwitchOption.graph
                                ? TextButton(
                                    onPressed: () =>
                                        data.switchView(SwitchOption.table),
                                    child: const Icon(
                                        Icons.arrow_back_ios_new_rounded),
                                  )
                                : TextButton(
                                    onPressed: () => data.clearX(),
                                    child: const Text("Clear"))
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 10),
              data.firstData.isEmpty
                  ? const CircularProgressIndicator()
                  : data.defaultOption == SwitchOption.table
                      ? Expanded(
                          child: TableUI(
                            data: data.resutlData.isEmpty
                                ? data.firstData
                                : data.resutlData,
                          ),
                        )
                      : Expanded(
                          child: Row(
                            children: [
                              Column(
                                children: data.resutlData.isEmpty
                                    ? data.firstData.first.keys
                                        .toList()
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child:
                                                      Center(child: Text(e))),
                                            ))
                                        .toList()
                                    : data.resutlData.first.keys
                                        .toList()
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child:
                                                      Center(child: Text(e))),
                                            ))
                                        .toList(),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: data.giveMeChart(data.resutlData),
                                ),
                              ),
                            ],
                          ),
                        )
            ],
          );
        }),
      ),
    );
  }
}
