import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Html(
                data:
                """<p><span style="font-size:18px"><strong>1.&nbsp;&nbsp; &nbsp;Eligibility:</strong></span></p>
                    <p><span style="font-size:16px">The User must undertake to adhere to the eligibility to enter into a contract in view of section 11 of <strong>The Indian Contract Act, 1872</strong>. The User shall agree to represent and warrant that the User is at the age of 18 or above and is fully able and competent to understand and agree the terms, conditions, obligations, affirmations, representation, and warranties as set forth in this Agreement.</span></p>
                    <p><span style="font-size:18px"><strong>2.&nbsp;&nbsp; &nbsp;Compliance of Law:&nbsp;</strong></span></p>
                    <p><span style="font-size:16px">Both the User and the <strong>Food Delivery Platform </strong>must be in compliance with all laws and regulations in the country in which they live while accessing and using the Service. The User must agree to use the Services only in compliance with terms &amp; conditions, applicable law, and in a manner that does not violate legal rights or those of any third party/parties.</span></p>
                    <p><span style="font-size:18px"><strong>3.&nbsp;&nbsp; &nbsp;Legal implications of online food ordering:&nbsp;</strong></span></p>
                    <p><span style="font-size:16px">Every FDP shall state in its Agreement that it provides online food ordering services by entering into contractual arrangements with Restaurants on a principal to principal basis for the purpose of listing their food and beverages for online ordering by the Users on the FDP (“Restaurant Partners”). Users can access the list of food and beverages of the Restaurant Partners listed on FDP and place orders against the Restaurant Partners through <strong>Food Delivery Platform&nbsp;</strong>which the Restaurant Partner may or may not accept at its absolute discretion.&nbsp;</span></p>
                    <p><span style="font-size:18px"><strong>4.&nbsp;&nbsp; &nbsp; TERMS OF SERVICE OF FDP:</strong></span></p>
                    <p><span style="font-size:16px">1)&nbsp;&nbsp; &nbsp;The FDP shall make it clear that it is not either a &nbsp;manufacturer or a seller or distributor of food or beverages but only places an order against the partner restaurant on behalf of the User customer pursuant to the aforesaid contract and facilitate the sale and purchase of food and beverages between the two, under the contract for sale and purchase of food and beverages.</span></p>
                    """),
          ),
        ),
      ),
    );
  }
}
