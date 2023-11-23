import {Component, OnInit} from '@angular/core';
import {AuthService} from "../../services/auth.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit{

  constructor(
    private as: AuthService,
    private router: Router,
    ) {
  }

  ngOnInit(): void {
  }

  login(form) {
    let data= form.value
    this.as.login(data.email, data.password)
      .then(result => console.log(result))
      .then(() =>{
        this.router.navigate(['/'])
      })
      .catch(err => console.log(err))
  }
}

