import 'package:fare_now_provider/util/app_colors.dart';

import '../abstraction/abstract_button.dart';

import '../part_of_file/part.dart';

class FareNowOutlineButton extends FarenowAbstractButton with ButtonMixin {
  @override
  Widget buildFarenowButton(FarenowButton? farenowButton) =>
      super.getButton(farenowButton);

  @override
  Color bgcolor({Color? color}) {
    return color ?? AppColors.white;
  }

  @override
  TextStyle textStyle({Color? color}) {
    return TextStyle(
        color: color ?? AppColors.solidBlue,
        fontSize: 18,
        fontWeight: FontWeight.w500);
  }
}
