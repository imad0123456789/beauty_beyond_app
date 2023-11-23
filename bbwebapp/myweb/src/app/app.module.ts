import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {AngularFireModule} from "@angular/fire/compat";
import {AngularFireStorageModule } from "@angular/fire/compat/storage";
import{AngularFireAuthModule} from '@angular/fire/compat/auth';


import { HomeComponent } from './components/home/home.component';
import { AboutusComponent } from './components/aboutus/aboutus.component';
import { BookingComponent } from './components/booking/booking.component';
import { BookingFormComponent } from './components/booking-form/booking-form.component';
import { DoctorsComponent } from './components/doctors/doctors.component';
import { LoginComponent } from './components/login/login.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { PricesComponent } from './components/prices/prices.component';
import { SignupComponent } from './components/signup/signup.component';
import * as config from '../../firebaseconfig.js'

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    AboutusComponent,
    BookingComponent,
    BookingFormComponent,
    DoctorsComponent,
    LoginComponent,
    NavbarComponent,
    NotFoundComponent,
    PricesComponent,
    SignupComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    CommonModule,
    FormsModule,
    AngularFireAuthModule,
    AngularFireStorageModule,
    AngularFireModule.initializeApp(config.firebaseconfig),
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
