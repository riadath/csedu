import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCard extends StatefulWidget {
  final String uid;
  final String name;
  final String batch;
  final String bloodGroup;
  final String linkedin;
  const ProfileCard({
    required this.uid,
    required this.name,
    required this.batch,
    required this.bloodGroup,
    required this.linkedin,
    super.key,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Round Image with Button"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(140),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage("images/learn.png"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 18,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.person),
                    onPressed: _launchUrl,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                    ),
                    label: const Text(
                      "LinkedIn",
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    var url =
        Uri.parse('https://www.linkedin.com/in/reyadath-ullah-akib-053181199');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
