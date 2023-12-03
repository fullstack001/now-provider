import 'package:fare_now_provider/components/buttons-management/buttons/action_buttons.dart';
import 'package:fare_now_provider/components/buttons-management/buttons/outline_button.dart';
import 'package:fare_now_provider/components/buttons-management/buttons/tile_button.dart';

import '../buttons/text_button.dart';
import '../part_of_file/part.dart';

// this class for generating the all Farenow provider Buttons
/*abstract class FarenowButtonFactory {
  ButtonMixin? generateButton(BUTTONTYPE type) {
    switch (type) {
      case BUTTONTYPE.rectangular:
        return FareNowRectangularButton();
      case BUTTONTYPE.action:
        return FarenowActionButtons();
      case BUTTONTYPE.outline:
        return FareNowOutlineButton();
      case BUTTONTYPE.text:
        return FarenowTextButton();
      case BUTTONTYPE.tile:
        return FarenowTileButton();
      default:
        return null;
    }
  }
}*/
//modified code
mixin FarenowButtonFactory {
  ButtonMixin? generateButton(BUTTONTYPE type) {
    switch (type) {
      case BUTTONTYPE.rectangular:
        return FareNowRectangularButton();
      case BUTTONTYPE.action:
        return FarenowActionButtons();
      case BUTTONTYPE.outline:
        return FareNowOutlineButton();
      case BUTTONTYPE.text:
        return FarenowTextButton();
      case BUTTONTYPE.tile:
        return FarenowTileButton();
      default:
        return null;
    }
  }
}