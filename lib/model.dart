// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Blog {
  final String nama;
  final String pass;
  final String email;
  final String id;

  const Blog({
    required this.nama,
    required this.pass,
    required this.email,
    required this.id,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'nama': String nama,
        'pass': String pass,
        'email': String email,
        'id': String id,
      } =>
        Blog(nama: nama, pass: pass, email: email, id: id),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'pass': pass,
      'email': email,
      'id': id,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      nama: map['nama'] as String,
      pass: map['pass'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
