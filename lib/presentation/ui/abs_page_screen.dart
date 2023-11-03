import 'package:flutter/material.dart';

class AbsPageScreen extends StatelessWidget {
  const AbsPageScreen({super.key});

  final defaultTextStyle = const TextStyle(
      fontSize: 25,
      color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  Widget buildLoadingScreen(BuildContext context) {
    return _buildTextScreen(context, "Processing request");
  }

  Widget buildEmptyScreen(BuildContext context) {
    return _buildTextScreen(context, "No values found yet");
  }

  Widget buildFailedScreen(BuildContext context, String errorMessage) {
    return _buildTextScreen(context, "Exception occurred: $errorMessage");
  }

  Widget _buildTextScreen(BuildContext context, String message) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.yellow,
      width: screenSize.width,
      height: screenSize.height * 0.65,
      child: Center(
        child: Text(
          message,
          style: defaultTextStyle,
        ),
      ),
    );
  }
}