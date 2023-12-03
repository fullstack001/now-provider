// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nb_utils/nb_utils.dart';

import '../../util/app_colors.dart';
import '../buttons-management/part_of_file/part.dart';

// ignore: must_be_immutable

class FarenowRadioButtons extends StatefulWidget {
  List<String> list;
  bool isRadio;
 Function(List<String>, List<int>, int)? onSelected;
  final List<int>? selectedIndex;
  FarenowRadioButtons(
      {Key? key,
      required this.list,
      required this.isRadio,
      this.selectedIndex,
      required this.onSelected})
      : super(key: key);

  @override
  State<FarenowRadioButtons> createState() => _FarenowRadioButtonsState();
}

class _FarenowRadioButtonsState extends State<FarenowRadioButtons> {
  late List<int> _selected;
  @override
  void initState() {
    _selected = widget.selectedIndex ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: List.generate(
            widget.list.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: widget.isRadio
                                ? Colors.transparent
                                : checkSelected(index)
                                    ? AppColors.solidBlue
                                    : const Color.fromRGBO(0, 104, 225, 0.1))),
                    tileColor: const Color.fromRGBO(0, 104, 225, 0.1),
                    onTap: () =>
                        // return widget.onTap(addOrRemoveIndex(index));
                        widget.onSelected!(
                            addOrRemoveIndex(index), _selected, index),
                    trailing: !widget.isRadio
                        ? getCheckBox(checkSelected(index))
                        : null,
                    leading: widget.isRadio
                        ? getRadioButton(checkSelected(index))
                        : null,
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.list[index],
                        style: const TextStyle(
                          fontFamily: "Roboto",
                            fontSize: 18,
                            color: Color(0xff555555),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  checkSelected(int index) {
    if (_selected.contains(index)) {
      return true;
    } else {
      return false;
    }
  }

  List<String> addOrRemoveIndex(int index) {
    if (_selected.isNotEmpty) {
      if (widget.isRadio) {
        _selected.assign(index);
        return getSelectedData();
      } else {
        if (_selected.contains(index)) {
          _selected.remove(index);
          return getSelectedData();
        } else {
          _selected.add(index);
          return getSelectedData();
        }
      }
    } else {
      if (widget.isRadio) {
        _selected.assign(index);
        return getSelectedData();
      } else {
        _selected.add(index);
        return getSelectedData();
      }
    }
  }

  List<String> getSelectedData() {
    if (_selected.isNotEmpty && widget.list.isNotEmpty) {
      List<String> selectedData = [];
      for (var i = 0; i < _selected.length; i++) {
        selectedData.add(widget.list[_selected[i]]);
      }
      setState(() {});
      return selectedData;
    } else {
      setState(() {});
      return [];
    }
  }

  getRadioButton(checkSelected) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: white,
          shape: BoxShape.circle,
          border: Border.all(
              color: AppColors.solidBlue, width: checkSelected ? 9 : 1)),
    );
  }

  getCheckBox(checkSelected) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: checkSelected ? AppColors.solidBlue : null,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.solidBlue)),
      child: checkSelected
          ? const Center(
              child: Icon(
              Icons.check,
              color: white,
              size: 18,
            ))
          : null,
    );
  }
}
