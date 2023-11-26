import { Injectable } from '@angular/core';
import {AngularFirestore} from "@angular/fire/compat/firestore";
import { Observable } from 'rxjs';
import {Booking} from "../booking.model";


@Injectable({
  providedIn: 'root'
})
export class BookingService {

  constructor(private firestore: AngularFirestore) {
  }

  /*
  async addBooking(booking: any) {
    return await this.firestore.collection('bookings').add(booking);
  }

   */
  getBookings(): Observable<Booking[]> {
    return this.firestore.collection<Booking>('bookings').valueChanges();
  }

  addBooking(booking: Booking): Promise<any> {
    return this.firestore.collection('bookings').add(booking);
  }

  booking(id, year, month, day, hour) {
    return this.firestore.doc('book/' + id).set({
      year,
      month,
      day,
      hour,
      id,
    })

  }
}


