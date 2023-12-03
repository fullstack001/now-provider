import '../abstraction/abstract_button.dart';

import '../part_of_file/part.dart';

class FareNowRectangularButton extends FarenowAbstractButton with ButtonMixin {
  @override
  Widget buildFarenowButton(FarenowButton? farenowButton) =>
      super.getButton(farenowButton);
}
