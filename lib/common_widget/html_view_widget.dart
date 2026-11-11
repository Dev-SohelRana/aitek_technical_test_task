import 'package:aitek_task/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class HtmlViewWidget extends StatelessWidget {
  final String input;
  const HtmlViewWidget({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      ''' $input ''',
      customStylesBuilder: (element) {
        if (element.classes.contains('foo')) {
          return {'color': 'red'};
        }
        return null;
      },
      customWidgetBuilder: (element) {
        if (element.attributes['foo'] == 'bar') {
          // render a custom widget that takes the full width
        }
        if (element.attributes['fizz'] == 'buzz') {
          // render a custom widget that inlines with surrounding text
        }
        return null;
      },
      renderMode: RenderMode.column,
      textStyle: TextFontStyle.headlinePublicSans60012grey,
    );
  }
}
