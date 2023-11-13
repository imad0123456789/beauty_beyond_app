import {Injectable} from '@angular/core';
import firebase from "firebase/compat/app";
import 'firebase/compat/firestore'
import 'firebase/compat/auth'
import 'firebase/compat/storage'

import * as config from '../../firebaseconfig.js'

@Injectable({
  providedIn: 'root'
})
export class FireService {

  firebaseApplication;

  firestore: firebase.firestore.Firestore;
  auth: firebase.auth.Auth;
  storage: firebase.storage.Storage;
  currentlySignedInUserAvatarURL: string = "https://www.pngall.com/wp-content/uploads/5/User-Profile-Transparent.png";


  messages: any[] = [];


  constructor() {
    this.firebaseApplication = firebase.initializeApp(config.firebaseconfig);
    this.firestore = firebase.firestore();
    this.auth = firebase.auth();
    this.storage = firebase.storage();

    this.auth.onAuthStateChanged((user) => {
      if (user) {
        this.getMessages();
        this.getImageOfSignedInUser();
      }
    })


  }


  async getImageOfSignedInUser(): Promise<void> {
    this.currentlySignedInUserAvatarURL = await this.storage.ref('avatars')
      .child(this.auth.currentUser?.uid + "")
      .getDownloadURL();

  }

  async updateUserImage($event): Promise<void> {
    const img = $event.target.files[0];
    const uploadTask = await this.storage
      .ref(this.auth.currentUser?.uid + "")
      .put(img);
    this.currentlySignedInUserAvatarURL = await uploadTask.ref.getDownloadURL();
  }

  sendMessage(sendThisMessage: any) {
    let messageDTO: MessageDTO = {
      messageContent: sendThisMessage,
      timestamp: new Date(),
      user: 'amin'
    }
    this.firestore.collection('myChat')
      .add(messageDTO)
  }

  getMessages(): void {
    this.firestore
      .collection('booking')
      .where('userId', '==', 'HMTLrh35F8xowu8VuakV')
      .onSnapshot(snapshot => {
        snapshot.docChanges().forEach(change => {
          if (change.type == "added") {
            this.messages.push({id: change.doc.id, data: change.doc.data()});
          }
          if (change.type == 'modified') {
            const index = this.messages.findIndex(document => document.id != change.doc.id);
            this.messages[index] =
              {id: change.doc.id, data: change.doc.data()}
          }
          if (change.type == 'removed') {
            this.messages = this.messages.filter(m => m.id != change.doc.id);
          }
        })
      })
  }

  register(email: string, password: string): void {
    this.auth.createUserWithEmailAndPassword(email, password);
  }

  signIn(email: string, password: string): void {
    this.auth.signInWithEmailAndPassword(email, password);
  }

  signOut() {
    this.auth.signOut();
  }

}


export interface MessageDTO {
  messageContent: string;
  timestamp: Date;
  user: string;
}
