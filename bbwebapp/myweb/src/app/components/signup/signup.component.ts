import {Component, OnInit} from '@angular/core';
import {AuthService} from "../../services/auth.service";
import {User} from "../../interfaces/user.interface";
import {UserService} from "../../services/user.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit{
  errorMessage:string ='';

  constructor(
    private as: AuthService,
    private us: UserService,
    private router: Router,
    ) {
  }

  ngOnInit() {
  }

  signup(form) {
    let data: User = form.value
    this.as.signup(data.email, data.password)
      .then(result => {
        this.errorMessage=''
        this.us.addNewUser(result.user?.uid, data.name, data.family, data.age, data.mobileNumber, data.email)
          .then(() => {
            this.router.navigate(['/'])

          }).catch(err => console.log('fs',err))
      })
      .catch(err => {
        console.log('a',err)
        this.errorMessage = err.message
      })
  }
}
