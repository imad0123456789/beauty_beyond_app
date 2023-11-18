import {Component, OnInit} from '@angular/core';
import {Price} from "../../interfaces/prices.interface";


@Component({
  selector: 'app-prices',
  templateUrl: './prices.component.html',
  styleUrls: ['./prices.component.css']
})
export class PricesComponent implements OnInit{

  prices: Price[] =[
    {name: 'FORUNDERSØGELSE', price: 'Gratis', photoUrl :'assets/001.png'},
    {name: 'KONTROL EFTER 14 DAGE', price: 'Gratis', photoUrl :'assets/002.png'},
    {name: 'BOTOX BEHANDLING', price: '1500 DKK', photoUrl :'assets/003.png'},
    {name: 'FILLER BEHANDLING', price: '1800 DKK', photoUrl :'assets/004.png'},
  ]
  constructor() {
  }

  ngOnInit(): void {
  }

}
