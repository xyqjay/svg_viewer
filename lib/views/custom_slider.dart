import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_viewer/viewModel/config_model.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    final config = Provider.of<ConfigModel>(context, listen: false);
    sliderValue = config.scale.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigModel>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: _zoomOut,
          child: Icon(
            Icons.indeterminate_check_box_outlined,
            color: config.theme.imgColor,
          ),
        ),
        Slider(
            value: sliderValue, min: 1, max: 8, onChanged: _sliderValueChande),
        InkWell(
          onTap: _zoomIn,
          child: Icon(
            Icons.add_box_outlined,
            color: config.theme.imgColor,
          ),
        )
      ],
    );
  }

  void _zoomOut() {
    final config = Provider.of<ConfigModel>(context, listen: false);
    config.zoomOut();
    setState(() {
      sliderValue = config.scale.toDouble();
    });
  }

  void _zoomIn() {
    final config = Provider.of<ConfigModel>(context, listen: false);
    config.zoomIn();
    setState(() {
      sliderValue = config.scale.toDouble();
    });
  }

  void _sliderValueChande(double value) {
    setState(() {
      sliderValue = value;
    });
    final config = Provider.of<ConfigModel>(context, listen: false);
    config.zoomValue(value);
  }
}
