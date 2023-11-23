import { Injectable } from '@angular/core';
import {AngularFirestore} from "@angular/fire/compat/firestore";

@Injectable({
  providedIn: 'root'
})
export class PricesService {

  constructor(private fs: AngularFirestore) { }

  getAllPrices(){
    return this.fs.collection('prices').stateChanges()
  }
}
