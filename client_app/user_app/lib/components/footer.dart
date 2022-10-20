import 'package:flutter/material.dart';
import 'package:user_app/custom_components/customText.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/models/onboarding_model.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: kBlackColor,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 16,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Image.asset(
                    splashContents[0].image,
                  ),
                ),
                Text(
                  'Brikshya',
                  style: kAppName.copyWith(
                    color: kMediumGreenColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: redhat,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          size.width > 950
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const AddressColumn(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                          ),
                          child: CustomTextStyleOne(
                            text: 'Need help',
                            myColor: kBlackColor,
                          ),
                        ),
                        ContactWidget(),
                      ],
                    ),
                    const EmailWidget(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AddressColumn(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            top: 24.0,
                          ),
                          child: CustomTextStyleOne(
                            text: 'Need help',
                            myColor: kBlackColor,
                          ),
                        ),
                        ContactWidget(),
                      ],
                    ),
                    const EmailWidget(),
                  ],
                ),
          Column(
            crossAxisAlignment: size.width > 850
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: size.width > 850
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const CustomTextStyle(
                        text: 'Privacy Policy',
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const CustomTextStyle(
                        text: 'Terms & Conditions',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Copyright Ⓒ 2022 Brikshya. All Right Reserved',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const SizedBox(
        width: 360,
        child: ListTile(
          leading: Icon(
            Icons.mail_outlined,
            size: 32,
            color: kOrangeColor,
          ),
          title: Text(
            'brikshya.nursery@gmail.com',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const SizedBox(
        width: 300,
        child: ListTile(
          leading: Icon(
            Icons.phone_in_talk_outlined,
            size: 32,
            color: kOrangeColor,
          ),
          title: CustomTextStyleOne(
            text: '+977-9811771892',
            fontSize: 18,
            myColor: kBlackColor,
          ),
          subtitle: Text(
            'Sun-Fri: 7:00 AM - 7:00 PM',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

class AddressColumn extends StatelessWidget {
  const AddressColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 32.0,
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            width: 270,
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: const ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                size: 48,
                color: kMediumGreenColor,
              ),
              title: Text(
                'Raghunathpur, Lahan3 Siraha, Nepal',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            top: 8.0,
          ),
          child: Text(
            'Always open',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextStyle extends StatelessWidget {
  final String text;
  const CustomTextStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 20,
      ),
    );
  }
}

class HeadingCustomTextStyle extends StatelessWidget {
  final String text;
  const HeadingCustomTextStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: kBlackColor,
      ),
    );
  }
}
