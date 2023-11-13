import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import {RouterOutlet} from "@angular/router";
import { AppComponent } from './app.component';
import {FormsModule} from "@angular/forms";
import { HomeComponent } from './components/home/home.component';
import { LoginPageComponent } from './components/login-page/login-page.component';
import { SignUpPageComponent } from './components/sign-up-page/sign-up-page.component';
import { BookingPageComponent } from './components/booking-page/booking-page.component';
import { NotFounComponentComponent } from './components/not-foun-component/not-foun-component.component';
import { NavbarComponent } from './components/navbar/navbar.component';


// @ts-ignore
@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    LoginPageComponent,
    SignUpPageComponent,
    BookingPageComponent,
    NotFounComponentComponent,
    NavbarComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    RouterOutlet,
  ],
  providers: [],
  bootstrap: [AppComponent]
})


export class AppModule { }
