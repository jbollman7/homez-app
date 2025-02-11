import { inject, Injectable } from '@angular/core';
import { HousingLocation } from '../housing-location';
import { DatabaseService } from './database.service';

@Injectable({
  providedIn: 'root'
})
export class HousingService {

  databaseService: DatabaseService = inject(DatabaseService);
  protected housingLocationList: HousingLocation[] = [];
  constructor() { }

  getAllHousingLocations(): HousingLocation[] {
    //return this.housingLocationList;
    return this.databaseService.getAllHousingLocations();
  }

  getHousingLocationById(id: Number): HousingLocation | undefined {
    return this.housingLocationList.find(x => x.id === id);
  }

  submitApplication(firstName: string, lastName: string, email: string): void {
    console.log(firstName, lastName, email);
  }
}
