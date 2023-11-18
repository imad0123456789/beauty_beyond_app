import { Injectable } from '@angular/core';
import firebase from  "firebase/compat/app";
import 'firebase/compat/firestore'

import * as Config from '../../firebaseconfig'

@Injectable({
  providedIn: 'root'
})
export class FireService {

  firebaseApplication;
  firestore: firebase.firestore.Firestore;

  constructor() {
    this.firebaseApplication= firebase.initializeApp(Config.firebaseconfig)
    this.firestore = firebase.firestore();

    this.firestore.collection('helloworld').add({
      myfield: "Hello World"
    })
  }
}
