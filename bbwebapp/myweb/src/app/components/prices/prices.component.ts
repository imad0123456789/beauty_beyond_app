import {Component, OnInit} from '@angular/core';
import {Price} from "../../interfaces/prices.interface";
import {PricesService} from "../../services/prices.service";


@Component({
  selector: 'app-prices',
  templateUrl: './prices.component.html',
  styleUrls: ['./prices.component.css']
})
export class PricesComponent implements OnInit {


  prices: Price[] = [
    {
      name: 'FORUNDERSØGELSE',
      price: 'Gratis',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/bb-app-b5395.appspot.com/o/001.png?alt=media&token=e7cc7304-1a27-41b8-8d00-92a83b071787'
    },
    {
      name: 'KONTROL EFTER 14 DAGE',
      price: 'Gratis',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/bb-app-b5395.appspot.com/o/002.png?alt=media&token=ccffa0d7-b931-43f3-aae5-22192ab85aa4'
    },
    {
      name: 'BOTOX BEHANDLING ',
      price: '1500 DKK',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/bb-app-b5395.appspot.com/o/003.png?alt=media&token=bf725916-b5a3-4a74-bbf6-68c3be7b912f'
    },
    {
      name: 'FILLER BEHANDLING',
      price: '1800 DKK',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/bb-app-b5395.appspot.com/o/004.png?alt=media&token=913178f4-98bf-49ac-afa8-b97f33cb08ac'
    },
  ]

  ngOnInit(): void {
  }
}




/*
  prices: Price[] = [];
  constructor(private gs: PricesService) {
  }

  ngOnInit(): void {
    this.gs.getAllPrices().subscribe(data => {
      this.prices= data.map(element => {
        return{
          id:element.payload.doc.id,
          ...element.payload.doc.data()

        }
      })

    })
  }


  bookTid(id) {
    console.log('added'. id)
  }
}

*/
