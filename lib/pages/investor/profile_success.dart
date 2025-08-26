import 'package:flutter/material.dart';
import 'package:nobleassets/utils/widget.dart';
import '../../../utils/helpers.dart';

class ProfileSuccess extends StatefulWidget {
  const ProfileSuccess({Key? key}) : super(key: key);

  @override
  _ProfileSuccessState createState() => _ProfileSuccessState();
}

class _ProfileSuccessState extends State<ProfileSuccess> {
  @override
  void initState() {
    Helpers.fetchLatestSavings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/success.gif'),
                  height: 150.0,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30.0),
                Widgets.buildText("Profile Saved Successfully!", context,
                    isCenter: true,
                    isBold: true,
                    size: 35.0,
                    lines: 10,
                    color: "text.secondary"),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: Widgets.buildButton(context,
                          background: Theme.of(context).colorScheme.secondary,
                          radius: 50.0,
                          horizontal: 50.0,
                          vertical: 18.0),
                      child: Widgets.buildText("Go Home", context,
                          isMedium: true, color: "text.white")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
