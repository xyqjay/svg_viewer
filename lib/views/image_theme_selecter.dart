import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_viewer/viewModel/config_model.dart';

class ImageThemeSelecter extends StatefulWidget {
  const ImageThemeSelecter({super.key});

  @override
  State<ImageThemeSelecter> createState() => _ImageThemeSelecterState();
}

class _ImageThemeSelecterState extends State<ImageThemeSelecter> {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigModel>(context, listen: true);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Theme:',
          style: TextStyle(color: config.theme.imgColor),
        ),
        ...config.themes.map((e) => ImageThemeCell(
              theme: e,
              isSelected: config.isSelect(e),
              action: () {
                config.setTheme(e);
              },
            ))
      ],
    );
  }
}

class ImageThemeCell extends StatelessWidget {
  final ImageTheme theme;
  final bool isSelected;
  final VoidCallback action;
  const ImageThemeCell(
      {super.key,
      required this.theme,
      required this.isSelected,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: theme.backGroundColor,
                border: Border.all(color: Colors.grey, width: 4),
              ),
              child: Container(
                alignment: Alignment.bottomRight,
                width: 16,
                height: 16,
                decoration: BoxDecoration(color: theme.imgColor),
                child: Visibility(
                  visible: isSelected,
                  child: Icon(
                    Icons.check_box_rounded,
                    size: 12,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
