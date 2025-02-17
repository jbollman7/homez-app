import { Inject, inject, Injectable } from '@angular/core';
import { HousingLocation } from '../housing-location';
import { DatabaseService } from './database.service';
import { Observable, pipe } from 'rxjs';
import { tap, catchError } from 'rxjs/operators'
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class HousingService {

  //databaseService: DatabaseService = inject(DatabaseService);
  protected housingLocationList: HousingLocation[] = [];
  constructor(@Inject(HttpClient) private readonly http: HttpClient
  ) {}

  readonly API_PATH = 'http://localhost:8080'


  public GetAllHousingListings(): Observable<Object> {
        return this.http.get(`${this.API_PATH}/listings`)
            .pipe(
                tap((response) => {
                  return response
                }),
                catchError((error) => {
                    throw error;
                })
            );
  }

  public GetHousingLocationById(id: Number): Observable<Object> {

        return this.http.get(`${this.API_PATH}/listings/${id}`)
            .pipe(
                tap((response) => {
                  return response
                }),
                catchError((error) => {
                    throw error;
                })
            );
  }

  submitApplication(firstName: string, lastName: string, email: string): void {
    console.log(firstName, lastName, email);
  }
}
