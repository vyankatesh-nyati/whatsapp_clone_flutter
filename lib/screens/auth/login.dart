import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_flutter/utils/utils.dart';
import 'package:whatsapp_clone_flutter/widgets/common/custom_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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

  void onSave() {
    String phoneNumber = phoneEditingController.text.trim();

    if (phoneNumber.isNotEmpty && _country != null) {
      phoneNumber = "+${_country!.phoneCode}$phoneNumber";

      ref
          .read(authControllerProvider)
          .signInWithPhoneNumber(context, phoneNumber);
    } else {
      showSnackbar(context: context, content: "Please enter all fields");
    }
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
                onPressed: onSave,
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
