// src/app/booking-calendar/booking-calendar.component.ts
import { Component, OnInit } from '@angular/core';
import { BookingService} from "../../services/booking.service";
import {Booking} from "../../booking.model";

@Component({
  selector: 'app-booking-calendar',
  templateUrl: './booking-calendar.component.html',
  styleUrls: ['./booking-calendar.component.css'],
})
export class BookingCalendarComponent implements OnInit {
  bookings: Booking[] = [];
  selectedDate: string = '';
  selectedHour: string = '';

  constructor(private bookingService: BookingService) {}

  ngOnInit(): void {
    this.loadBookings();
  }

  loadBookings(): void {
    this.bookingService.getBookings().subscribe((bookings) => {
      this.bookings = bookings;
    });
  }

  onSelectDate(date: string): void {
    this.selectedDate = date;
  }

  onSelectHour(hour: string): void {
    this.selectedHour = hour;
  }

  onBook(): void {
    if (this.selectedDate && this.selectedHour) {
      const booking: Booking = {
        date: this.selectedDate,
        hour: this.selectedHour,
      };

      this.bookingService.addBooking(booking).then(() => {
        console.log('Booking added successfully');
        this.loadBookings(); // Reload bookings after a new booking is added
      });
    }
  }
}
