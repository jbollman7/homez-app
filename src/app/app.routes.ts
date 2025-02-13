import { Routes } from '@angular/router';
import { HomeComponent } from '../home/home.component';
import { DetailsComponent } from './details/details.component';

export const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    title: 'Homey Page'
  },
  {
    path: 'details/:id',
    //component: DetailsComponent,
    loadComponent: () => import('./details/details.component').then((d) => d.DetailsComponent),
    title: 'Details Page'
  }

];
