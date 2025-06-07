import { Routes } from '@angular/router';
import { LandingComponent } from './landing/landing.component';

export const routes: Routes = [

  {
    path: '',
    component: LandingComponent,
    title: 'Landing Page'
  },
  {
    path: 'homes',
    loadComponent: () => import('../home/home.component').then((h) => h.HomeComponent),
    title: 'Homey Page'
  },
  {
    path: 'homes/details/:id',
    loadComponent: () => import('./details/details.component').then((d) => d.DetailsComponent),
    title: 'Details Page'
  }
];
