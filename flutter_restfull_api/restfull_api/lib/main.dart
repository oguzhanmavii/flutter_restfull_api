import 'package:flutter/material.dart';
import 'package:restfull_api/models/user_model.dart';
import 'package:restfull_api/services/user_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserService _service = UserService();
  bool? isLoading;

  List<UsersModelData?> users = [];

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Restfull Api With Flutter "),
            actions: const [
              Icon(Icons.flutter_dash),
            ],
          ),
          body: isLoading == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : isLoading == true
                  ? ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("${users[index]!.email}"),
                          subtitle: Text(users[index]!.email!),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(users[index]!.avatar!),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("Bir sorun ile karşılaşıldı"),
                    )),
    );
  }
}
