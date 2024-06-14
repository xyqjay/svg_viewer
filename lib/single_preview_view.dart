import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:svg_viewer/viewModel/config_model.dart';
import 'package:svg_viewer/viewModel/select_files_model.dart';
import 'package:svg_viewer/views/header_tool_view.dart';

class SinglePreviewView extends StatefulWidget {
  const SinglePreviewView({super.key});

  @override
  State<SinglePreviewView> createState() => _SinglePreviewViewState();
}

class _SinglePreviewViewState extends State<SinglePreviewView> {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigModel>(context);
    final scale = _getScale(config.scale);
    final model = Provider.of<SelectFileModel>(context, listen: false);
    final file = File(model.items.first);
    return Container(
      color: config.theme.backGroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HeaderTool(),
          const Spacer(),
          Container(
            // padding: const EdgeInsets.all(8),
            // decoration: BoxDecoration(
            //     border: Border.all(color: config.theme.imgColor, width: 1)),
            child: SvgPicture.file(
              file,
              width: 100 * scale,
              height: 100 * scale,
              color: config.theme.imgColor,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  double _getScale(int scale) {
    if (scale > 4) {
      return scale - 4;
    } else if (scale < 4) {
      return scale / 4;
    } else {
      return 1;
    }
  }
}
