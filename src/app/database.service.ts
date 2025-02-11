import { Injectable } from '@angular/core';
import Database from 'better-sqlite3';
import { HousingLocation } from '../housing-location';

@Injectable({
  providedIn: 'root'
})
export class DatabaseService {
  private db;

  constructor() {
    this.db = new Database('housing.db', { verbose: console.log });
  }

  getAllHousingLocations(): HousingLocation[]  {
    const query = this.db.prepare('SELECT * FROM house_table;');
    const rawData = query.all();

    return rawData.map(row => this.transformToHousingLocation(row));
  }

  private transformToHousingLocation(row: any): HousingLocation {
    return {
      id: row.id,
      name: row.name,
      city: row.city,
      state: row.state,
      photo: row.photo,
      availableUnits: row.availableUnits,
      wifi: row.wifi,
      laundry: row.laundry
    }
  }
}
