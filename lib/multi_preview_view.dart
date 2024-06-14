import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:svg_viewer/viewModel/config_model.dart';
import 'package:svg_viewer/viewModel/select_files_model.dart';
import 'package:svg_viewer/views/header_tool_view.dart';

class MultiPreviewView extends StatefulWidget {
  const MultiPreviewView({super.key});

  @override
  State<MultiPreviewView> createState() => _MultiPreviewViewState();
}

class _MultiPreviewViewState extends State<MultiPreviewView> {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigModel>(context);
    final model = Provider.of<SelectFileModel>(context, listen: false);
    final images = model.items;

    return Container(
      color: config.theme.backGroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HeaderTool(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 10 - config.scale,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(images.length, (index) {
                  final file = File(images[index]);
                  return Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: config.theme.imgColor, width: 1),
                    ),
                    child: SvgPicture.file(
                      file,
                      color: config.theme.imgColor,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
