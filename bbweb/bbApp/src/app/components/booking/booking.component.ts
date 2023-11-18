import { Component } from '@angular/core';
//import { BookingService } from '../booking.service';

@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrls: ['./booking.component.css']
})
export class BookingComponent {
  booking = { name: '', date: '', time: '' };

  constructor(
    //private bookingService: BookingService
    ) {}

  submitBooking() {
    // this.bookingService.addBooking(this.booking);
    // You can also reset the form or navigate to another page after submitting
  }

}
