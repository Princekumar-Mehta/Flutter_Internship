import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddData {
  void addData(String full_name,String gmail_id,String photo_url){
    FirebaseFirestore.instance
        .collection('users')
        .add({'full_name': full_name,'gmail_id':gmail_id,'photo_url':photo_url});
  }
}