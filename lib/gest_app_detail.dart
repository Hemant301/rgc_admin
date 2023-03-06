import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:rgc_admin/apicall/api.dart';
import 'package:rgc_admin/apicall/bloc.dart';
import 'package:rgc_admin/apicall/modal.dart';

class GestAppDetail extends StatefulWidget {
  const GestAppDetail({super.key});

  @override
  State<GestAppDetail> createState() => _GestAppDetailState();
}

class _GestAppDetailState extends State<GestAppDetail> {
  @override
  Widget build(BuildContext context) {
    Map rcvd = ModalRoute.of(context)!.settings.arguments as Map;
    print(rcvd);
    homeBloc.fetchGuestDetails(rcvd['id']);
    homeBloc.fetchGestReq();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/gest_approval');
              }
            },
            child: const Icon(Icons.arrow_back_ios)),
        backgroundColor: const Color(0xffFFB800),
        centerTitle: true,
        title: const Text('Guest List',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        iconTheme: const IconThemeData(color: Colors.black),

        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<GuestDetailModal>(
                stream: homeBloc.getLiveDeatils.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text("Member Name    -  ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text(snapshot.data!.list[0].memberDetail!.name),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text("Member Code     -  ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text(snapshot.data!.list[0].memberCode!),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text("Member Mobile  -  ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text(snapshot.data!.list[0].memberDetail!.phone!),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<GuestDetailModal>(
                stream: homeBloc.getLiveDeatils.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: List.generate(
                        snapshot.data!.list.length,
                        (i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                elevation: 5,
                                child: Column(children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        color: Color(0xffB8D4FF),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text("No. of Guests    -  ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue)),
                                            Text(snapshot
                                                .data!.list[i].user.length
                                                .toString()),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                                "Date                    -  ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue)),
                                            Text(snapshot.data!.list[i].date
                                                .toString()),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                                "Time                   -  ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue)),
                                            Text(snapshot.data!.list[i].time
                                                .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 217, 217, 217),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Guest Name",
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
                                              flex: 2,
                                              child: Text(
                                                "Status    ",
                                                style: TextStyle(
                                                  color: Colors.black,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              snapshot
                                                  .data!.list[i].user.length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .list[i]
                                                                      .user[
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                )),
                                                            // const Expanded(
                                                            //     flex: 2, child: Text("fdgdfgfd")),
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .list[i]
                                                                      .user[
                                                                          index]
                                                                      .phone
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                )),

                                                            Expanded(
                                                              flex: 2,
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          5),
                                                                  height: 40,
                                                                  // width: 60,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0xff8F8F8F),
                                                                        width:
                                                                            2),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.1),
                                                                        spreadRadius:
                                                                            1,
                                                                        blurRadius:
                                                                            1,
                                                                        offset: const Offset(
                                                                            1,
                                                                            3), // changes position of shadow
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      DropDown(
                                                                    showUnderline:
                                                                        false,
                                                                    items: const [
                                                                      "Reject",
                                                                      "Approved",
                                                                      "Pending",
                                                                    ],
                                                                    onChanged:
                                                                        (value) async {
                                                                      if (value ==
                                                                          "Approved") {
                                                                        Map data = await homeApi.updateStatus(
                                                                            context,
                                                                            guestId:
                                                                                snapshot.data!.list[i].user[index].id.toString(),
                                                                            status: "1");
                                                                        if (data['success'] ==
                                                                            true) {
                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          setState(
                                                                              () {});
                                                                        }
                                                                      } else if (value ==
                                                                          "Pending") {
                                                                        Map data = await homeApi.updateStatus(
                                                                            context,
                                                                            guestId:
                                                                                snapshot.data!.list[i].user[index].id.toString(),
                                                                            status: "0");
                                                                        if (data['success'] ==
                                                                            true) {
                                                                          setState(
                                                                              () {});
                                                                        }
                                                                      }

                                                                      value ==
                                                                              "Reject"
                                                                          ? UpdatePopuP(
                                                                              context,
                                                                              snapshot.data!.list[i].user[index].id.toString(),
                                                                              "2",
                                                                              rcvd['id'])
                                                                          : Container();

                                                                      print(
                                                                          value);
                                                                      // _accounttype = value.toString();
                                                                    },
                                                                    hint: Text(
                                                                      getStatus(snapshot
                                                                          .data!
                                                                          .list[
                                                                              i]
                                                                          .user[
                                                                              index]
                                                                          .status),
                                                                      style: TextStyle(
                                                                          color: getStatusColor(snapshot
                                                                              .data!
                                                                              .list[i]
                                                                              .user[index]
                                                                              .status),
                                                                          fontSize: 12),
                                                                    ),
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .expand_more,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            // : Expanded(
                                                            //     flex: 2,
                                                            //     child: Center(
                                                            //       child: Text(
                                                            //         getStatus(snapshot
                                                            //             .data!
                                                            //             .list[i]
                                                            //             .user[
                                                            //                 index]
                                                            //             .status),
                                                            //         style: TextStyle(
                                                            //             color: getStatusColor(snapshot
                                                            //                 .data!
                                                            //                 .list[
                                                            //                     i]
                                                            //                 .user[
                                                            //                     index]
                                                            //                 .status),
                                                            //             fontSize:
                                                            //                 12),
                                                            //       ),
                                                            //     )),
                                                          ],
                                                        ),
                                                        const Divider(
                                                          color: Colors.black26,
                                                        )
                                                      ],
                                                    ),
                                                  ))),
                                    ),
                                  )
                                ]),
                              ),
                            )),
                  );
                })
          ]),
        ),
      ),
    );
  }

  getStatus(int i) {
    if (i == 0) return "Pending";
    if (i == 1) return "Approved";
    if (i == 2) return "Rejected";

    return "null";
  }

  Color getStatusColor(int i) {
    if (i == 0) return Colors.grey;
    if (i == 1) return Colors.green;
    if (i == 2) return Colors.red;

    return Colors.grey;
  }
}

UpdatePopuP(context, guestId, status, rcvdId) {
  TextEditingController reasonController = TextEditingController();
  showDialog(
      context: context,
      builder: (_) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: AlertDialog(
                backgroundColor: Colors.white,
                elevation: 5,
                insetPadding: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.3,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Enter Reason for Rejection',
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                // fontFamily: font,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                homeBloc.fetchGuestDetails(rcvdId);
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                                color: const Color(0xff8F8F8F), width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: reasonController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "  Enter Reason for Rejection....."),
                            // minLines: 5,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width - 40,
                        //   height: 2,
                        //   color: Colors.grey,
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    homeApi.updateStatus(context,
                                        guestId: guestId,
                                        status: status,
                                        reason: reasonController.text);
                                    homeBloc.fetchGuestDetails(rcvdId);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(1,
                                                2), // changes position of shadow
                                          )
                                        ],
                                      ),
                                      child: const Center(child: Text('Save'))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ));
}
