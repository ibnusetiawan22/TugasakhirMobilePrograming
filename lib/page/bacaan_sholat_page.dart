import 'dart:convert';
import 'package:bacaansholat/model/model_bacaan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class BacaanSholat extends StatefulWidget {
  const BacaanSholat({Key? key}) : super(key: key);

  @override
  _BacaanSholatState createState() => _BacaanSholatState();
}

class _BacaanSholatState extends State<BacaanSholat> {
  Future<List<ModelBacaan>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/data/bacaanshalat.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ModelBacaan.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bacaan Sholat'),
      ),
      backgroundColor: Color.fromARGB(255, 0, 149, 255),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 80),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 174, 215, 241)),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'assets/images/kalig_rafi.png',
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Bacaan Sholat",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                    text:
                                        "Bacaan sholat dari doa Iftitah Sampai Salam"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: ReadJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<ModelBacaan>;
                      return ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              margin: EdgeInsets.all(15),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: Text(
                                    items[index].name.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Container(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Text(
                                                    items[index]
                                                        .arabic
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Text(
                                                    items[index]
                                                        .latin
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8,
                                                      right: 8,
                                                      top: 5),
                                                  child: Text(
                                                      items[index]
                                                          .terjemahan
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
