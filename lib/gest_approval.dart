import 'package:flutter/material.dart';

class GuestApprovel extends StatelessWidget {
  const GuestApprovel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFB800),
        centerTitle: true,
        title: const Text('Guest Approvel',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        // actions: const [
        //   Icon((Icons.notifications)),
        //   SizedBox(
        //     width: 10,
        //   ),
        //   Icon((Icons.menu)),
        //   SizedBox(
        //     width: 10,
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 176, 199, 235),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Member Name",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Phone No.       ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "       ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: MediaQuery.of(context).size.width,
                    child: Column(
                        children: List.generate(
                            4,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Hemant Kumar",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          )),
                                      // const Expanded(
                                      //     flex: 2, child: Text("fdgdfgfd")),
                                      const Expanded(
                                          flex: 2,
                                          child: Text(
                                            "8210925188",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          )),

                                      InkWell(
                                        onTap: () {
                                          // bookingDetailPopUp(
                                          //     context,
                                          //     bookingHistory[
                                          //         index]);
                                          Navigator.pushNamed(
                                              context, "/gest_app_detail");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Center(
                                              child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 4),
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                  ),
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
