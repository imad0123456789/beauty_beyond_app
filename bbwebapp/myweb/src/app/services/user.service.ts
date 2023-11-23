import { Injectable } from '@angular/core';
import {AngularFirestore} from "@angular/fire/compat/firestore";

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private fs: AngularFirestore) {


  }

  addNewUser(id, name, family, age, mobileNumber, email ){
    return this.fs.doc('users/'+ id).set({
      name,
      family,
      age,
      mobileNumber,
      email,
    })

  }
}

