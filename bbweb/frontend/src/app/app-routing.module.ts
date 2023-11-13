import {NgModule} from "@angular/core";
import {RouterModule, Routes} from "@angular/router";
import {HomeComponent} from "./components/home/home.component";
import {LoginPageComponent} from "./components/login-page/login-page.component";
import {SignUpPageComponent} from "./components/sign-up-page/sign-up-page.component";
import {BookingPageComponent} from "./components/booking-page/booking-page.component";
import {NotFounComponentComponent} from "./components/not-foun-component/not-foun-component.component";

const routes: Routes=[
  { path:'', component: HomeComponent},
  { path:'login', component: LoginPageComponent},
  { path:'signup', component: SignUpPageComponent},
  { path:'booking', component: BookingPageComponent},
  { path:'**', component: NotFounComponentComponent},

  ];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})

export class AppRoutingModule{}
