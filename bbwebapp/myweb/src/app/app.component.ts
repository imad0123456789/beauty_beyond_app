import { Component } from '@angular/core';
import { FireService } from './fire.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'myweb';

  constructor(private fireService: FireService){
    
  }
}
