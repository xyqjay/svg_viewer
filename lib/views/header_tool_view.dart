import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_viewer/viewModel/config_model.dart';
import 'package:svg_viewer/viewModel/select_files_model.dart';
import 'package:svg_viewer/views/custom_slider.dart';
import 'package:svg_viewer/views/image_theme_selecter.dart';

class HeaderTool extends StatelessWidget {
  const HeaderTool({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigModel>(context, listen: true);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
            final model = Provider.of<SelectFileModel>(context, listen: false);
            model.clearFiles();
          },
          child: const Icon(Icons.arrow_back_outlined),
        ),
        const Spacer(),
        const ImageThemeSelecter(),
        const SizedBox(width: 40),
        Text(
          'Scale: ',
          style: TextStyle(color: config.theme.imgColor),
        ),
        const CustomSlider(),
        const Spacer(),
      ],
    );
  }
}
