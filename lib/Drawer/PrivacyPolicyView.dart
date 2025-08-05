import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.white,
          elevation: 0,
          title: Text("Privacy Policy",
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500)),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,);

            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 23,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Html(
                data:
                    """ <div class="list-element">  <h3>Unregistered &amp; Registered Users</h3>  <p>As and when decided by Dial-a-Meal™ certain services may or may not require registration. Registration has its own benefits as explained in the why sign-up page, users may clearly understand that access to services on the Dial-a-Meal™ platform is at the discretion of Dial-a-Meal™ management.&nbsp;</p>  </div>
                <div class="list-element">  <h3>Commitment to Respect &amp; Protect Customer‘s Privacy</h3>  <p>Dial-a-Meal™, respects, protects &amp; takes steps to protect &amp; safeguard the complete privacy of our customers. We strive to take all care possible of the information that is received from you.</p>  </div>
                <div class="list-element">  <h3>Collection of Information&nbsp;</h3>  <p>When you setup an account with us, contact us, or participate in activities on our site, we gather personal information from you such as name, e-mail address, mobile phone number, etc. We do not collect personal information from you when you visit our site unless you intend to advertise or use our services or want to know more about them. We may however, track the non-personal information about your visit which may include your domain name, webpage or complete URL from which you entered our sites , your IP address &amp; how much time you spend on our pages etc.</p>  </div>
                <div class="list-element">  <h3>Links to other sites</h3>  <p>You may come across links to other sites as you browse our site. Dial-a-Meal™’s privacy policies do not apply to those sites. We cannot be held accountable for the reliability of the service and data of the other sites, and thus are not responsible for their privacy policy. We recommend you to read the other sites’ privacy policy.&nbsp;</p>  </div>
                 <div class="list-element">  <h3>Opt-out&nbsp;</h3>  <p>Please contact www.dialameal.in at this email id –&nbsp;<a href="mailto:dialameal@suxes.in">dialameal@suxes.in</a>, if you no longer wish to receive non-essential and marketing material from us.&nbsp;&nbsp;</p>  </div>
                 <div class="list-element">  <h3>Security Safeguards</h3>  <p><a href="https://dialameal.in">www.dialameal.in</a>&nbsp;uses stringent security guidelines and some of the highest security standards to protect our customers from security issues, and any loss and misuse of their information.&nbsp;</p>  </div>
              <div class="list-element">  <h3>Query</h3>  <p>Feel free to contact Dialameal.in at this email id –&nbsp;<a href="mailto:dialameal@suxes.in">dialameal@suxes.in</a>&nbsp;for any further questions on our privacy policy.</p>  </div>
              <div class="list-element">  <h3>Use of Information</h3>  <p>All information shared with Dial-a-Meal™ (as part of using any of our services) is available only with Dial-a-Meal™. Dial-a-Meal™ does not share individual information of users with the restaurants or any other third party except in cases wherein such information sharing becomes necessary to provide a particular service. For example your details are needed to be shared with the restaurant to process an order. We use personal information to personalize and customize the service to you. In addition, we use the information to promote services to you and for product improvement purposes. We also use the information to troubleshoot issues; for our safety and to protect us against error, fraud, and crimes; diagnose problems; as advised as time of information collection; and to administer the terms and conditions. We may share this information with other corporate affiliates and entities for the same reasons mentioned above.&nbsp;</p>  </div>
                  """),
          ),
        ),
      ),
    );
  }
}
