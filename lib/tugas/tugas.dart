import 'dart:convert';
import 'package:http/http.dart' as http; //get Api
import 'package:flutter/material.dart';
import 'package:flutter_crud/tugas/tugas_view.dart';

class TugasPage extends StatelessWidget {
  const TugasPage({Key? key}) : super(key: key);

  Future<List<dynamic>> ambilAlbum() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?per_page=15'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            style: TextStyle(color: Color.fromARGB(255, 20, 21, 21)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(245, 247, 247, 1),
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ambilAlbum(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TugasViewPage(
                                      id: snapshot.data[index]['id'])));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    snapshot.data[index]['avatar']),
                              ),
                              title: Text(snapshot.data[index]['first_name'] +
                                  " " +
                                  snapshot.data[index]['last_name']),
                              subtitle: Text(snapshot.data[index]['email']),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('BUY TICKETS'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('LISTEN'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const KirimPage()),
          // );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
