import 'package:fare_now_provider/util/app_colors.dart';

import '../abstraction/abstract_button.dart';

import '../part_of_file/part.dart';

class FarenowTextButton extends FarenowAbstractButton with ButtonMixin {
  @override
  Widget buildFarenowButton(FarenowButton? farenowButton) =>
      super.getButton(farenowButton);

  @override
  ShapeBorder? outlinedBorder() {
    return null;
  }

  @override
  TextStyle? textStyle({Color? color}) {
    return TextStyle(
      color: color ?? AppColors.solidBlue,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Color? bgcolor({Color? color}) {
    return color ?? Colors.transparent;
  }

  @override
  double? elevation() {
    return 0;
  }
}
