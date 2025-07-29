import 'package:flutter/material.dart';
import 'package:flower_shop/theme/app_string.dart';
import 'package:flower_shop/theme/app_colors.dart';

class SignUpConente extends StatelessWidget {
  const SignUpConente({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // children: [
      //   Text(AppStrings.loginScreenWelcomeText),
      //   SizedBox(height: 50),
      //   Padding(
      //     padding: EdgeInsets.all(16),
      //     child: TextField(
      //       decoration: InputDecoration(
      //         fillColor: AppColors.whiteApp,
      //         filled: true,
      //         labelText: AppStrings.loginScreenPhonenumberTextFiled,
      //         border: const OutlineInputBorder(),
      //       ),
      //     ),
      //   ),
      //
      //
      //   Padding(
      //     padding: EdgeInsets.all(16),
      //     child:TextField(
      //       decoration: InputDecoration(
      //         fillColor: AppColors.whiteApp,
      //         filled: true,
      //         labelText: AppStrings.loginScreenPasswordTextFiled,
      //         border: OutlineInputBorder(),
      //       ),
      //     ),
      //   ),
      //   ForgetPasswordRow(firstWhiteText: 'هل نسيت كلمه المرور ؟'),
      //   ElevatedButton(onPressed: () {Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const HomeScreen()),
      //   );}, child: Text('تسجيل الدخول ')),
      //
      //   Padding(
      //     padding: EdgeInsets.only(top: 15),
      //     child: ForgetPasswordRow(
      //       firstWhiteText: 'إنشاء حساب ',
      //       secoednBlcakText: 'ليس لديك حساب ؟',
      //     ),
      //   ),
      // ],
    );
  }
}
