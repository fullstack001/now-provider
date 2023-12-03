import 'package:fare_now_provider/screens/bottom_navigation.dart';
import 'package:fare_now_provider/screens/service_settings.dart';
import 'package:flutter/material.dart';

class ServiceQuestionsScreen extends StatefulWidget {
  @override
  _ServiceQuestionsScreenState createState() => _ServiceQuestionsScreenState();
}

class _ServiceQuestionsScreenState extends State<ServiceQuestionsScreen> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers = [];
  var _nameController;
  static List<String> questionsList = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    controllers.add(TextEditingController());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  addQuestionsField() {
    controllers.add(TextEditingController());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          leadingWidth: 0,
          title: Text(
            "Services Questions",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        body: Container(
          width: width,
          height: height,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 21.0, right: 29.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 34,
                  ),
                  Text(
                    "Frequently Asked Questions :",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controllers.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TextFormField(
                                controller: controllers[index],
                                validator: (v) {
                                  if (v!.trim().isEmpty)
                                    return 'Please enter something';
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffF3F4F4),
                                  hintText: "Enter your question",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff757575),
                                      fontSize: 16),
                                  enabledBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                    color: Color(0xffF3F4F4),
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffF3F4F4),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              index == controllers.length - 1
                                  ? InkWell(
                                      onTap: () {
                                        addQuestionsField();
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color(0xff979797),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: ButtonTheme(
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          BottomNavigation.changeProfileWidget(
                              ServiceSettings());
                        },
                        child: Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff00B181),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// get questions text-fields
  List<Widget> _textfield() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < questionsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: QuestionsTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == questionsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          questionsList.insert(0, "");
        } else
          questionsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Color(0xff979797) : Colors.red,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class QuestionsTextFields extends StatefulWidget {
  final int index;
  QuestionsTextFields(this.index);
  @override
  _QuestionsTextFieldsState createState() => _QuestionsTextFieldsState();
}

class _QuestionsTextFieldsState extends State<QuestionsTextFields> {
  var _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _ServiceQuestionsScreenState.questionsList[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) =>
          _ServiceQuestionsScreenState.questionsList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter your Questions'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
