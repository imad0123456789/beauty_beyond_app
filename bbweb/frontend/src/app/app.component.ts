import { Component } from '@angular/core';
import {FireService} from "./fire.service";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'frontend';
  sendThisMessage: any;
  email: string= "";
  password: string= "";


  constructor(public fireService: FireService) {

  }
}
