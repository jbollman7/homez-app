import { Component, inject } from '@angular/core';
import { HousingLocationComponent } from '../housing-location/housing-location.component'
import { HousingLocation } from '../housing-location';
import { HousingService } from '../app/housing.service';

@Component({
  selector: 'app-home',
  imports: [HousingLocationComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  housingLocationList: HousingLocation[] = [];
  housingService: HousingService = inject(HousingService);

  constructor() {
    this.housingLocationList = this.housingService.getAllHousingLocations();
  }
}
