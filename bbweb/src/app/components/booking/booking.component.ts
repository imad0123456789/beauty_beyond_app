import {Component, OnInit} from '@angular/core';
import { BookingService } from '../../services/booking.service';
import {AuthService} from "../../services/auth.service";
import {UserService} from "../../services/user.service";
import {Router} from "@angular/router";


@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrls: ['./booking.component.css']
})
export class BookingComponent implements OnInit {
  errorMessage:string ='';

  constructor(
    private authService: AuthService,
    private bookingService: BookingService,
    private router: Router,
  ){}

  booking =
    {
      Date: '31-12-2023',
      day: 'Friday',
      Time: '10:30',
      DoctorCategory : 'botox',
      doctorId: 'ok2pEeFZyosKRka30AY2',
      doctorName: 'Kassem Mannaki',
      status: 'upcoming',
      userId: 'qvJLNUwNh1j2EbYGMMr7',
    }


  //booking = { name: 'Imad', date: '25-12-2023', time: '10:00' };


  submitBooking() {
    this.bookingService.addBooking(this.booking)
      .then(() =>{
        this.router.navigate(['/'])
      })
    setTimeout(() => {
      window.alert('Your booking was completed successfully');
    }, 100);
    // You can also reset the form or navigate to another page after submitting
  }



  ngOnInit(): void {
  }

}
