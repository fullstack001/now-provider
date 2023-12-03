import 'package:fare_now_provider/screens/select_work.dart';
import 'package:flutter/material.dart';

class FindCustomersScreen extends StatefulWidget {
  static const id = 'find_customers_screen';
  @override
  _FindCustomersScreenState createState() => _FindCustomersScreenState();
}

class _FindCustomersScreenState extends State<FindCustomersScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 89,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 45.5,
                  ),
                  const Text(
                    "Let's find you customers?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 38),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "What's your line of work?",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffBDBDBD)),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  TextField(
                    onTap: () {
                      Navigator.pushNamed(context, SelectWorkScreen.id);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your line of work",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
