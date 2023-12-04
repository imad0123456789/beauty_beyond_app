import {Component, OnInit} from '@angular/core';
import {AuthService} from "../../services/auth.service";
import {Router} from "@angular/router";
import {Observable} from "rxjs";
import {AngularFirestore} from "@angular/fire/compat/firestore";

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit{
  isOpen: boolean = false;
  isUser: boolean = false;
  userName$: Observable<string> = new Observable<string>();


  constructor(
    private as: AuthService,
    private router: Router,
    private firestore: AngularFirestore){
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
