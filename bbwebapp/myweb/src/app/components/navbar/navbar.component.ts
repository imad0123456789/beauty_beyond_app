import {Component, OnInit} from '@angular/core';
import {AuthService} from "../../services/auth.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit{
  isOpen: boolean = false;
  isUser: boolean = false;

  constructor(private as: AuthService,private router: Router,){
  }


  ngOnInit() {
    this.as.user.subscribe(user => {
      if(user){
        this.isUser =true;
        this.as.userId = user.uid
      }

      else{
        this.isUser=false
        this.as.userId = ''
      }

    })
  }

  toggleNavbar() {
    this.isOpen = !this.isOpen
  }


  logout(){

    this.as.logout()
      .then(() => console.log('OUT'))
      .then(() =>{
        this.router.navigate(['/login'])
      })

  }

}
