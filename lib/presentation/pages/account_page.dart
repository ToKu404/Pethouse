import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/account/edit_profile_page.dart';
import 'package:pethouse/presentation/widgets/card_account.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:pethouse/utils/styles.dart';

class AccountPage extends StatelessWidget {
  static const ROUTE_NAME = 'account';
  String username = 'IkhsanGanteng';
  String email = 'ikhsangantengclalu@gmail.com';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/image_user.png'),
                const SizedBox(
                  height: 5,
                ),
                Text(username, style: kTextTheme.subtitle1),
                const SizedBox(
                  height: 3,
                ),
                Text(email, style: kTextTheme.bodyText1),
                const SizedBox(
                  height: 5,
                ),
                GradientButton(
                  height: 34,
                  width: 120,
                  text: 'Edit Profile',
                  onTap: () {
                    Navigator.pushNamed(context, EditProfilePage.ROUTE_NAME);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ChangePassword(
                  title: 'ChangePassword',
                  trailing: Icons.navigate_next,
                  leading: Icons.lock,
                ),
                ChangeLanguage(
                  title: 'Language',
                  trailing: Icons.navigate_next,
                  leading: Icons.language,
                ),
                CardDarkMode(),
                LogOut(
                  title: 'Log Out',
                  trailing: null,
                  leading: Icons.logout,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
