import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nearchat/screens/login/login_screen.dart';
import 'package:nearchat/screens/signup/signup_screen.dart';
import 'package:nearchat/screens/start_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: StartScreen.id,
        routes: {
          StartScreen.id: (context) => const StartScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void signout() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    googleSignIn.signOut();
  }

  void signinWithEmail() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // firebaseAuth.createUserWithEmailAndPassword( email: 'amirzainpubg@gmail.com', password: 'amir1243@#@#');
    print("hello");
    firebaseAuth.sendPasswordResetEmail(email: 'amirzainpubg@gmail.com');
  }

  void googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    User? firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseUser != null) {
      // Check is already sign up
      FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference docRef = db.collection("users");
      final QuerySnapshot result = await db
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        // Update data to server if new user
        db.collection('users').doc(firebaseUser.uid).set({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid
        });
      }
    }
  }

  void getData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference docRef = db.collection("users");
    QuerySnapshot res = await docRef.get();
    List<QueryDocumentSnapshot> data = res.docs;
    print(data.first.data());

    // final DocumentReference<Map<String, dynamic>> result = FirebaseFirestore
    //     .instance
    //     .collection('users')
    //     .doc("FEqj7meoujjBxIGfKCKL");
    // print(result.delete());
    // final List<DocumentSnapshot> documents = result.;
  }

  void _incrementCounter() {
    // getData();
    // googleSignIn();
    signinWithEmail();
    // signout();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: signout, child: Text("signout")),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
