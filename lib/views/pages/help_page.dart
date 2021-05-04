import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
        title: Text(
          Languages.of(context).labelContactUs,
          style: TextStyle(color: Colors.black54),)
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Languages.of(context).labelContactUs,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                onTap: () {
                  _launchURL("tel:" + '+255715785672');
                },
                leading:
                    Icon(Icons.phone, color: Theme.of(context).primaryColor),
                title: Text('Call us: (+255-715-785-672)'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  _launchURL("sms:" + '+255715785672');
                },
                leading: Icon(
                  FontAwesomeIcons.sms,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('SMS: (+255-715-785-672)'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  _launchURL("email:" + 'support@auntierafiki.co.tz');
                },
                leading: Icon(
                  Icons.email,
                  color: Colors.red,
                ),
                title: Text('Email: support@auntierafiki.co.tz'),
              ),
            )
          ],
        ),
      )),
    );
  }

  void _launchURL(String uri) async {
    String url = uri;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch';
    }
  }
}
