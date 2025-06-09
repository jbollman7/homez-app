import { Inject,  Injectable } from '@angular/core';
import { HousingLocation } from '../housing-location';
import { Observable } from 'rxjs';
import { catchError, map } from 'rxjs/operators'
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class HousingService {

  constructor(@Inject(HttpClient) private readonly http: HttpClient
  ) {}

  readonly API_PATH = 'http://localhost:8080'


  public GetAllHousingListings(): Observable<HousingLocation[]> {
    return this.http.get<HousingLocation[]>(`${this.API_PATH}/listings`).pipe(
      map((housingLocations: HousingLocation[]) => {
        // Map the response to a HousingLocation object
        return housingLocations.map((housingLocation: HousingLocation) => ({
          id: housingLocation.id,
          name: housingLocation.name,
          units: housingLocation.units,
          city: housingLocation.city,
          laundry: housingLocation.laundry,
          photo: housingLocation.photo,
          rental: housingLocation.rental,
          state: housingLocation.state,
          wifi: housingLocation.wifi
        }))
      }),
      catchError((error) => {
        // Handle the error here
        throw error;
      })
    );
  }

 public GetHousingLocationById(id: number): Observable<HousingLocation> {
  return this.http.get(`${this.API_PATH}/listings/${id}`).pipe(
    map((housingLocation: any) => {
      // Map the response to a HousingLocation object
      return {
        id: housingLocation.id,
        name: housingLocation.name,
        units: housingLocation.units,
        city: housingLocation.city,
        laundry: housingLocation.laundry,
        photo: housingLocation.photo,
        rental: housingLocation.rental,
        state: housingLocation.state,
        wifi: housingLocation.wifi
      } as HousingLocation;
    }),
    catchError((error) => {
      // Handle the error here
      throw error;
    })
  );
}

  submitApplication(firstName: string, lastName: string, email: string): void {
    console.log(firstName, lastName, email);
  }
}
