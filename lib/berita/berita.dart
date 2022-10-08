import 'dart:convert';
import 'package:http/http.dart' as http; //get Api
import 'package:flutter/material.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({Key? key}) : super(key: key);

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
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(snapshot.data[index]['avatar']),
                    ),
                    title: Text(snapshot.data[index]['first_name'] +
                        " " +
                        snapshot.data[index]['last_name']),
                    subtitle: Text(snapshot.data[index]['email']),
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => DetailScreen(
                    //               id: snapshot.data[index]['id'])));
                    // },
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
