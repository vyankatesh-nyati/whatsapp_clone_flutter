import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/widgets/common/custom_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneEditingController = TextEditingController();
  Country? _country;

  @override
  void dispose() {
    super.dispose();
    phoneEditingController.dispose();
  }

  void countryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _country = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        backgroundColor: backgroundColor,
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "WhastApp will need to verify your phone number.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: countryPicker,
                child: const Text("Pick country"),
              ),
            ),
            Row(
              children: [
                if (_country != null) Text("+${_country!.phoneCode}"),
                const SizedBox(width: 12),
                TextField(
                  controller: phoneEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "phone number",
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 90,
              child: CustomButton(
                onPressed: () {},
                buttonText: "NEXT",
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
