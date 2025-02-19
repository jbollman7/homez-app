import { Component } from '@angular/core';
import { RouterLink, RouterModule } from '@angular/router'

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
  imports: [RouterModule, RouterLink]

})
export class AppComponent {
  title = 'homez-app';
}
