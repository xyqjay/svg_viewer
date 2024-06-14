import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_viewer/multi_preview_view.dart';
import 'package:svg_viewer/single_preview_view.dart';
import 'package:svg_viewer/start_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:svg_viewer/viewModel/config_model.dart';
import 'dart:io';

import 'package:svg_viewer/viewModel/select_files_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SelectFileModel()),
          ChangeNotifierProvider(create: (context) => ConfigModel()),
        ],
        child: MyHomePage(
          title: 'SVG Viewer',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  final GlobalKey<_MyHomePageState> widgetKey = GlobalKey();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<SelectFileModel>(
        builder: (context, model, child) {
          switch (model.viewType) {
            case ViewType.start:
              return const StartView();
            case ViewType.single:
              return DropTarget(
                  onDragDone: _onDragDone, child: const SinglePreviewView());
            case ViewType.multi:
              return DropTarget(
                  onDragDone: _onDragDone, child: const MultiPreviewView());
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _onClickPick(context);
      //   },
      //   tooltip: 'Select File',
      //   child: const Icon(Icons.folder_open),
      // ),
    );
  }

  void _onDragDone(DropDoneDetails details) {
    final model = Provider.of<SelectFileModel>(context, listen: false);
    model.selectXFiles(details.files);
  }

  void _onClickPick(BuildContext context) {
    final model = Provider.of<SelectFileModel>(context, listen: false);
    switch (model.viewType) {
      case ViewType.start:
        _pickSVG(context);
      case ViewType.single:
        _pickSVG(context);
      case ViewType.multi:
        _pickFolder(context);
    }
  }

  void _pickSVG(BuildContext context) async {
    // Do Not Use BuildContext in Async Gaps: Why and How to Handle Flutter Context Correctly
    // https://medium.com/nerd-for-tech/do-not-use-buildcontext-in-async-gaps-why-and-how-to-handle-flutter-context-correctly-870b924eb42e
    // final context = widget.widgetKey.currentContext;

    await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['svg']).then((value) {
      if (value != null) {
        File file = File(value.files.first.path!);
        final model = Provider.of<SelectFileModel>(context, listen: false);
        model.selectFile(file.path);
      } else {
        // User canceled the picker
      }
      return null;
    });
  }

  void _pickFolder(BuildContext context) async {
    await FilePicker.platform.getDirectoryPath().then((value) {
      if (value != null) {
        debugPrint(value);
      }
      return null;
    });
  }
}
