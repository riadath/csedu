import 'package:csedu/Constants.dart';
import 'package:csedu/firebase_storage_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Background extends StatefulWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.grey[900],
            width: MediaQuery.of(context).size.width,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     fit: BoxFit.fitHeight,
            //     image: AssetImage('images/vectorWave0.jpg'),
            //   ),
            // ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String batch;
  final String bloodGroup;
  final String linkedin;
  final String roll;
  const ProfileCard({
    required this.uid,
    required this.name,
    required this.roll,
    required this.batch,
    required this.bloodGroup,
    required this.linkedin,
    required this.email,
    super.key,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  StorageImage image = StorageImage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              FutureBuilder(
                future: image.downloadURL(widget.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data.toString()),
                            fit: BoxFit.fill),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20),
              InfoCard(
                info: widget.name,
                icon: Icon(Icons.person, color: Colors.teal.shade400),
                ifMail: false,
                ifLi: false,
              ),
              InfoCard(
                info: 'Roll: ${widget.roll}',
                icon: Icon(Icons.front_hand, color: Colors.teal.shade400),
                ifMail: false,
                ifLi: false,
              ),
              InfoCard(
                info: widget.email,
                icon: Icon(Icons.email, color: Colors.teal.shade400),
                ifMail: true,
                ifLi: false,
              ),
              InfoCard(
                info: widget.bloodGroup,
                icon: Icon(Icons.bloodtype, color: Colors.teal.shade400),
                ifMail: false,
                ifLi: false,
              ),
              InfoCard(
                info: '${widget.batch}th Batch',
                icon: Icon(Icons.class_, color: Colors.teal.shade400),
                ifMail: false,
                ifLi: false,
              ),
              InfoCard(
                info: widget.linkedin,
                icon: Icon(Icons.class_, color: Colors.teal.shade400),
                ifMail: false,
                ifLi: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String info;
  final Icon icon;
  final bool ifMail, ifLi;
  const InfoCard({
    required this.ifMail,
    required this.ifLi,
    required this.info,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: icon,
          trailing: (ifMail || ifLi)
              ? const Icon(Icons.directions)
              : const Icon(
                  Icons.query_builder,
                  color: gPrimaryColorLight,
                ),
          title: Text(
            ifLi ? 'LinkedIn' : info,
            style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 18,
                color: Colors.teal.shade400),
          ),
        ),
      ),
      onTap: () {
        if (ifMail) {
          _launchUrl('mailto:$info');
        } else if (ifLi) {
          _launchUrl(info);
        }
      },
    );
  }
}

Future<void> _launchUrl(String link) async {
  var url = Uri.parse(link);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
