import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartagri/assistant.dart';
import 'package:smartagri/facilities/admin.dart';
import 'package:smartagri/facilities/roi.dart';
import 'package:smartagri/facilities/schemes.dart';
import 'package:smartagri/facilities/weather.dart';
import 'package:smartagri/phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gmaps_shops.dart';

class Facility extends StatefulWidget {
  const Facility({super.key});

  @override
  State<Facility> createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {
  Future<bool> checkAdminAccess() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (adminDoc.exists) {
      return adminDoc['isAdmin'] ?? false;
    }
    return false;
  }

  bool isLoading = false;
  bool english = true;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkAdminAccess().then((hasAccess) {
      setState(() {
        isAdmin = hasAccess;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 44, 41),
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.transparent,
          ),
          backgroundColor: const Color.fromARGB(255, 36, 69, 66),
          title: Text(english ? 'Facilities' : "सुविधाएं",
              style: const TextStyle(color: Colors.white)),
          actions: [
            Center(
                child: Text(!english ? 'हिन्दी  ' : 'English ',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            Switch(
              activeColor: const Color.fromARGB(255, 15, 44, 41),
              activeTrackColor: const Color.fromARGB(255, 219, 191, 157),
              inactiveThumbColor: const Color.fromARGB(255, 15, 44, 41),
              inactiveTrackColor: Colors.white,
              trackOutlineWidth: MaterialStateProperty.all(2),
              value: !english,
              onChanged: (value) {
                setState(() {
                  english = !value;
                });
              },
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            if (!isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Assistant(
                                      hindi: english,
                                    ))),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 219, 191, 157),
                                  borderRadius: BorderRadius.circular(12)),
                              height: 50,
                              width: size.width,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/assistant.png'),
                                    ),
                                    Text(
                                      english ? '    Assistant' : "    सहायक",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: Colors.black,
                                    )
                                  ])),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Weather())),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 219, 191, 157),
                                  borderRadius: BorderRadius.circular(12)),
                              height: 50,
                              width: size.width,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/forecast.png'),
                                    ),
                                    Text(
                                      english ? '    Weather' : "    मौसम",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: Colors.black,
                                    )
                                  ])),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ROI(
                                      english: english,
                                    ))),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Container(
                              height: 50,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 219, 191, 157),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/money.png'),
                                    ),
                                    Text(
                                      english
                                          ? '    Capital Requirement & ROI'
                                          : "    पूंजी आवश्यकता और आरओआई",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: Colors.black,
                                    )
                                  ])),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Schemes())),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Container(
                              height: 50,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 219, 191, 157),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/scheme.png'),
                                    ),
                                    Text(
                                      english
                                          ? '    Government Schemes'
                                          : "    सरकारी योजनाएं",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: Colors.black,
                                    )
                                  ])),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GMapShops())),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Container(
                              height: 50,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 219, 191, 157),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/shops.png'),
                                    ),
                                    Text(
                                      english
                                          ? '    Google Maps Shops'
                                          : "    गूगल मैप दुकानें",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: Colors.black,
                                    )
                                  ])),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isAdmin)
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Admin())),
                          child: Card(
                            color: Colors.transparent,
                            elevation: 8,
                            shadowColor: Colors.black,
                            child: Container(
                                height: 50,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 219, 191, 157),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage('assets/admin.png'),
                                      ),
                                      Text(
                                        english
                                            ? '    Admin Panel'
                                            : "    प्रशासक पैनल",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.chevron_right,
                                        size: 30,
                                        color: Colors.black,
                                      )
                                    ])),
                          ),
                        ),
                      const SizedBox(height: 20),
                      logoutBtn()
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  ElevatedButton logoutBtn() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await FirebaseAuth.instance.signOut();
          setState(() {
            isLoading = false;
          });
          if (mounted) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Otp()));
          }
        },
        child: Text(
          english ? 'Logout' : "लॉग आउट",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
