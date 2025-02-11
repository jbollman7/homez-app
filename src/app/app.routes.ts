import { Routes } from '@angular/router';
import { HomeComponent } from '../home/home.component';
import { DetailsComponent } from './details/details.component';

export const routes: Routes = [
  {
    component: HomeComponent,
    path: '',
    title: 'Homey Page'
  },
  {
    component: DetailsComponent,
    path: 'details/:id',
    title: 'Details Page'
  }

];
