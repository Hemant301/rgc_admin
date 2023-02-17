import 'package:flutter/material.dart';
import 'package:rgc_admin/apicall/bloc.dart';
import 'package:rgc_admin/apicall/modal.dart';
import 'package:rgc_admin/notify.dart';
import 'package:rgc_admin/util/userCred.dart';

class GuestApprovel extends StatelessWidget {
  const GuestApprovel({super.key});

  @override
  Widget build(BuildContext context) {
    homeBloc.fetchGestReq();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFB800),
        centerTitle: true,
        title: const Text('Guest Approval',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          InkWell(
            onTap: () {
              userCred.logoutUser();
              Navigator.pushNamed(context, '/login');
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TokenMonitor(),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<GuestReqListModal>(
              stream: homeBloc.getGuestReqListModal.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
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
                                  snapshot.data!.list.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  snapshot
                                                      .data!.list[index].name,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            // const Expanded(
                                            //     flex: 2, child: Text("fdgdfgfd")),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  snapshot
                                                      .data!.list[index].phone,
                                                  style: const TextStyle(
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
                                                    context, "/gest_app_detail",
                                                    arguments: {
                                                      'id': snapshot
                                                          .data!.list[index].id,
                                                      'name': snapshot.data!
                                                          .list[index].name,
                                                      'phone': snapshot.data!
                                                          .list[index].phone
                                                    });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Center(
                                                    child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 4),
                                                  child: Text(
                                                    "View",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                );
              })
        ]),
      ),
    );
  }
}
