import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {HomeComponent} from "./components/home/home.component";
import {LoginComponent} from "./components/login/login.component";
import {SignupComponent} from "./components/signup/signup.component";
import {BookingComponent} from "./components/booking/booking.component";
import {NotFoundComponent} from "./components/not-found/not-found.component";
import {DoctorsComponent} from "./components/doctors/doctors.component";
import {AboutusComponent} from "./components/aboutus/aboutus.component";
import {PricesComponent} from "./components/prices/prices.component";

const routes: Routes = [
  {path: '', component:HomeComponent },
  {path: 'login', component:LoginComponent },
  {path: 'signup', component:SignupComponent },
  {path: 'booking', component:BookingComponent },
  {path: 'doctors', component:DoctorsComponent },
  {path: 'aboutus', component:AboutusComponent },
  {path: 'prices', component:PricesComponent },
  {path: '**', component:NotFoundComponent }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }