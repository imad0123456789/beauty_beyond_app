import { Injectable } from '@angular/core';
import {AngularFirestore} from "@angular/fire/compat/firestore";


@Injectable({
  providedIn: 'root'
})
export class BookingService {

  constructor(private firestore: AngularFirestore) { }

  async addBooking(booking: any) {
    return await this.firestore.collection('bookings').add(booking);
  }

}
