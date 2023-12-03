import 'package:fare_now_provider/components/buttons-management/mixins/style_mixin.dart';
import 'package:fare_now_provider/components/buttons-management/style_model.dart';

import './part_of_file/part.dart';

@protected
// ignore: must_be_immutable
class FarenowButton extends StatelessWidget
    with FarenowButtonFactory, FarenowButtonStyle {
  late String? title;
  late VoidCallback? onPressed;
  late BUTTONTYPE? type;
  FarenowButtonStyleModel? style;

  FarenowButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.type,
      this.style})
      : assert(type != null),
        super(key: key) {
    title = title;
    onPressed = onPressed;
    type = type;
  }

  @override
  Widget build(BuildContext context) {
    return super.generateButton(type!)!.buildFarenowButton(this);
  }
}
