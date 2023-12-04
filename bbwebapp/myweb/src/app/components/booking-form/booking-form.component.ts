import { Component, OnInit } from '@angular/core';
import {AngularFirestore} from "@angular/fire/compat/firestore";

@Component({
  selector: 'app-booking-form',
  templateUrl: './booking-form.component.html',
  styleUrl: './booking-form.component.css',

})

export class BookingFormComponent implements OnInit {
  upcomingAppointments: any[] = [];
  book: any[] = [] ;
  bookId: string ='8MEcGTese34oGqskeIUe';
  completedAppointments: any[] = [];
  canceledAppointments: any[] = [];

  constructor(private firestore: AngularFirestore) {
  }

  ngOnInit(): void {

    this.firestore.collection('booking', ref => ref
      .where('status', '==', 'upcoming')).
    get().subscribe((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        // Assuming your appointments have a specific structure
        const appointment = doc.data();
        this.upcomingAppointments.push(appointment);
      });
    });
    this.firestore.collection('booking', ref => ref
      .where('status', '==', 'completed')).
    get().subscribe((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        // Assuming your appointments have a specific structure
        const appointment = doc.data();
        this.completedAppointments.push(appointment);
      });
    });
    this.firestore.collection('booking', ref => ref
      .where('status', '==', 'canceled')).
    get().subscribe((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        // Assuming your appointments have a specific structure
        const appointment = doc.data();
        this.canceledAppointments.push(appointment);
      });
    });
   }


  markAsCompleted(bookId: any): void {
    this.firestore.collection('booking').doc(bookId.id).update({ status: 'completed' })
      .then(() => {
        console.log('Appointment marked as completed successfully.');
        // You can perform additional actions or UI updates here
      })
      .catch((error) => {
        console.error('Error marking appointment as completed:', error);
      });
  }


}

