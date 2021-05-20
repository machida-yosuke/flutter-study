import 'package:clock_app/screens/components/time_in_hour_and_minute.dart';

import 'package:flutter/material.dart';

import 'clock.dart';
import 'country_card.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Newport Beach USA | PST",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TimeInHourAndMinute(),
            Spacer(),
            Clock(),
            Spacer(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CountryCard(
                      country: 'New York , USA',
                      timeZone: "+3 HRS | EST",
                      iconSrc: 'assets/icons/Liberty.svg',
                      time: "9:20",
                      priod: 'AM'),
                  CountryCard(
                      country: 'New York , USA',
                      timeZone: "+3 HRS | EST",
                      iconSrc: 'assets/icons/Liberty.svg',
                      time: "9:20",
                      priod: 'AM'),
                  CountryCard(
                      country: 'New York , USA',
                      timeZone: "+3 HRS | EST",
                      iconSrc: 'assets/icons/Liberty.svg',
                      time: "9:20",
                      priod: 'AM'),
                  CountryCard(
                      country: 'New York , USA',
                      timeZone: "+3 HRS | EST",
                      iconSrc: 'assets/icons/Liberty.svg',
                      time: "9:20",
                      priod: 'AM'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
