import 'package:assignment/infrastructure/auth/firebaseauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseauthprovider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseStorageprovider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final firebasefirestoreprovider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// from the authentication class that was implement from iauthservice
final authDataSourceProvider = Provider<Authentication>((ref) =>
    Authentication(firebaseAuth: ref.read(firebaseauthprovider), ref: ref));
