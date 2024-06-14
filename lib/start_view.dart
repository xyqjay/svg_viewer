import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_viewer/viewModel/select_files_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:desktop_drop/desktop_drop.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool _dragging = false;

  Offset? offset;
  bool isHighlighted = false;
  bool isUploading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        color: Colors.black,
        strokeWidth: 1,
        child: DropTarget(
          onDragDone: (detail) async {
            final model = Provider.of<SelectFileModel>(context, listen: false);
            model.selectXFiles(detail.files);
          },
          onDragUpdated: (details) {
            setState(() {
              offset = details.localPosition;
            });
          },
          onDragEntered: (detail) {
            setState(() {
              _dragging = true;
              offset = detail.localPosition;
            });
          },
          onDragExited: (detail) {
            setState(() {
              _dragging = false;
              offset = null;
            });
          },
          child: Container(
            alignment: Alignment.center,
            height: 200,
            width: 300,
            color: _dragging ? Colors.blue.withOpacity(0.4) : null,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Click this area to select .svg file.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 8),
                Text(
                  'Only SVG file allowed!',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> acceptFile(dynamic event) async {}
}
