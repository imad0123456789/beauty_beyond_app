import { Injectable } from '@angular/core';
import {Observable} from "rxjs";
import firebase from "firebase/compat/app";
//import 'firebase/compat/auth'
import {AngularFireAuth} from "@angular/fire/compat/auth";
import { filter } from 'rxjs/operators';


@Injectable({
  providedIn: 'root'
})
export class AuthService {

  user: Observable<firebase.User | null>
  userId: string =''
  //auth: firebase.auth.Auth

  constructor(private afAuth: AngularFireAuth ) {

    this.user= afAuth.user
  }

  signup(email, password){
    return this.afAuth.createUserWithEmailAndPassword(email,password)
  }

  login(email, password) {
    return this.afAuth.signInWithEmailAndPassword(email, password)
  }

  logout() {
    return this.afAuth.signOut()
  }



}
