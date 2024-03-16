import 'package:Pizza/All%20Screen/terms_of_service_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'privacy_policy_view.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
            setState(() {});
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text("About for app",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const TermsOfServiceView();
                                  },
                                ),
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Text(
                              "Terms of Service",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Color(0xff313848),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff313848),
                            size: 17,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: Color(0xffEAEDF3), width: 1.5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const PrivacyPolicyView();
                              },
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Text(
                              "Privacy Policy",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Color(0xff313848),
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff313848),
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: Color(0xffEAEDF3), width: 1.5))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          try {
                            launchUrl(Uri.parse("https://www.canada.ca/en/revenue-agency/services/tax/technical-information/excise-act-2001-forms.html"));
                          } on Exception catch (e) {
                            print("Error is $e");
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Text(
                              "Licenses and Registrations",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Color(0xff313848),
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff313848),
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: Color(0xffEAEDF3), width: 1.5))),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
