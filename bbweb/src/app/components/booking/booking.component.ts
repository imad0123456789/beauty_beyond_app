import { Component } from '@angular/core';
import { BookingService } from '../booking.service';

@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrls: ['./booking.component.css']
})
export class BookingComponent {
  booking = { name: 'Imad', date: '25-12-2023', time: '10:00' };

  constructor(private bookingService: BookingService) {}

  submitBooking() {
    this.bookingService.addBooking(this.booking);
    // You can also reset the form or navigate to another page after submitting
  }

}
