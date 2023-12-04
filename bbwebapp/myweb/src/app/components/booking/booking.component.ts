import {Component, OnInit} from '@angular/core';
import {inject} from '@angular/core';
import { NgbCalendar, NgbDatepickerModule, NgbDateStruct } from '@ng-bootstrap/ng-bootstrap';
import { FormsModule } from '@angular/forms';
import {JsonPipe, NgForOf} from '@angular/common';
import {AngularFirestore} from "@angular/fire/compat/firestore";
import firebase from "firebase/compat";
import {Router, RouterModule, Routes} from '@angular/router';
import firestore = firebase.firestore;
import {AngularFireAuth} from "@angular/fire/compat/auth";
import {AngularFireDatabase} from "@angular/fire/compat/database";


@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrls: ['./booking.component.css'],
  standalone: true,
  imports: [NgbDatepickerModule, FormsModule, JsonPipe, NgForOf],
  //providers: [JsonPipe]

})

export class BookingComponent implements OnInit {

  today = inject(NgbCalendar).getToday();
  model!: NgbDateStruct;
  Date!: { year: number; month: number };
  userId: string='';

  availableHours: string[] = ['9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '01:00 PM', '02:00 PM', '02:00 PM', '04:00 PM' ,'05:00 PM']; //  hours array
  selectedHour!: string;

  availableDoctors: string[] = ['Kassem Mannaki', 'Zeinab Mannaki']; //  hours array
  selectedDoctor!: string;

  availableCategory: string[] = ['Filler', 'Botox', 'Forundersøgelse', 'Kontrol Efter 14 Dage']; //  hours array
  selectedCategory!: string;

  isWeekend = (date: NgbDateStruct) => {
    const day = new Date(date.year, date.month - 1, date.day).getDay();
    return day === 0 || day === 6; // Sunday is 0, Saturday is 6
  };

  constructor(
    private firestore: AngularFirestore,
    private afAuth: AngularFireAuth,
    private calendar: NgbCalendar,
    private router: Router,
    )
  {
    this.today = this.serializeNgbDate(this.calendar.getToday());
    const today = this.calendar.getToday();
    this.model = this.calendar.getNext(today, 'd', 1);
  }


  book(): void {
    const data = {
      //today: this.today,
      //model: this.model,
      Date:  `${this.model.month}/${this.model.day}/${this.model.year}`,
      //date: this.date,
      Time: this.selectedHour,
      DoctorCategory: this.selectedCategory,
      doctorId: 'ok2pEeFZyosKRka30AY2',
      doctorName: this.selectedDoctor,
      status: 'upcoming',
      userId: this.userId,
    };

    this.firestore.collection('booking').add(data)
      .then(response => {
        console.log('Document added with ID: ', response.id)
      })
      .catch(error => {
        console.error('Error adding document: ', error);
      })
      .then(() => {
        this.router.navigate(['/schedule'])

      })

  }

  serializeNgbDate(ngbDate: NgbDateStruct): any {
    if (ngbDate) {
      return { year: ngbDate.year, month: ngbDate.month, day: ngbDate.day };
    }
    return null;
  }

  ngOnInit(): void {
    this.afAuth.authState.subscribe((user) => {
      if (user) {
        this.userId = user.uid;
      } else {
        this.userId = '';
      }
    });
  }


}
