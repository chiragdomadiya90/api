import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth kFirebaseAuth = FirebaseAuth.instance;

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

CollectionReference userCollection = firebaseFirestore.collection('user');

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
