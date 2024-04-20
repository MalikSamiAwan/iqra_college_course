import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  runApp(const CRUDAPPSQL());
}

class CRUDAPPSQL extends StatefulWidget {
  const CRUDAPPSQL({super.key});

  @override
  State<CRUDAPPSQL> createState() => _CRUDAPPSQLState();
}

class _CRUDAPPSQLState extends State<CRUDAPPSQL> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userName = '';
  String password = '';

  var settings =  ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'sami',
      password: '1234',
      db: 'iqra_college'
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SQL CRUD',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Text(
                'Login Page',
                style: TextStyle(color: Colors.blue, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text('User Email'),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: (v) {
                      userName = v;
                    },
                  ),
                )
              ],
            ),

            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text('Password'),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: (v) {
                      password = v;
                    },
                  ),
                )
              ],
            ),

            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () async{
                  String message='User name = $userName and password = $password';


                  var conn = await MySqlConnection.connect(settings);


                  var results = await conn.query('select * from user where email = ? And password = ?', [userName,password]);

                  if(results.isNotEmpty){
                    message='Successfully Login\n${results}\n\n';
                    showSimpleToast(context: context, message: message);
                  }else{
                    message='Failed Login\nWrong email or Password';
                    showSimpleToast(context: context, message: message);
                  }



                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}

void showSimpleToast({required BuildContext context, required String message}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text("${message}"),
  ));
}
