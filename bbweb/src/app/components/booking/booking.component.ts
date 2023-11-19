import { Component } from '@angular/core';
import { BookingService } from '../booking.service';
import {BookingInterface} from "../../interfaces/booking.interface";
import {WeekDay} from "@angular/common";

@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrls: ['./booking.component.css']
})
export class BookingComponent {

  booking =
    {
      Date: Date,
      day: 'Friday',
      Time: '10:30',
      DoctorCategory : 'botox',
      doctorId: 'ok2pEeFZyosKRka30AY2',
      doctorName: 'Kassem Mannaki',
      status: 'upcoming',
      userId: 'qvJLNUwNh1j2EbYGMMr7',
    }

  //booking = { name: 'Imad', date: '25-12-2023', time: '10:00' };

  constructor(private bookingService: BookingService) {}

  submitBooking() {
    this.bookingService.addBooking(this.booking);
    // You can also reset the form or navigate to another page after submitting
  }

}
