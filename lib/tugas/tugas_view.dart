import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //get Api

class Foto {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const Foto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Foto.fromJson(Map<String, dynamic> json) {
    return Foto(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class TugasViewPage extends StatelessWidget {
  const TugasViewPage({Key? key, required this.id}) : super(key: key);
  final int id;

  Future<Foto> tampilAlbum() async {
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users/' + id.toString()));
    if (response.statusCode == 200) {
      return Foto.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: FutureBuilder<Foto>(
        future: tampilAlbum(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListTile(
              leading: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(snapshot.data!.avatar),
              ),
              title: Text(
                  snapshot.data!.firstName + " " + snapshot.data!.lastName),
              subtitle: Text(snapshot.data!.email),
            );

            //Text(snapshot.data!.first_name);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
