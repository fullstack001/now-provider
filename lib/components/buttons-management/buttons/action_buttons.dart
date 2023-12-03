import 'package:fare_now_provider/components/buttons-management/part_of_file/part.dart';

import '../../../util/app_colors.dart';

class FarenowActionButtons extends FarenowAbstractButton with ButtonMixin {
  @override
  Widget buildFarenowButton(FarenowButton? farenowButton) =>
      super.getButton(farenowButton);

  @override
  ShapeBorder? outlinedBorder() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  }

  @override
  TextStyle? textStyle({Color? color}) {
    return TextStyle(
      color: color ?? AppColors.solidBlue,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  @override
  Color? bgcolor({Color? color}) {
    return color ?? Color(0xffF5F5F5);
  }

  @override
  double? elevation() {
    return 0;
  }
}
