import { PlayerClassService } from './../../services/player-class.service';
import { AuthService } from './../../services/auth.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { PlayerClass } from 'src/app/models/player-class';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy {

  // properties
  playerClasses: PlayerClass[] = [];

  // subscriptions
  private playerClassSubscription: Subscription | undefined;

  // dependencies
  auth = inject(AuthService);
  playerClassService = inject(PlayerClassService);

  ngOnInit() {
    this.subscribeToPlayerClassData();
  }

  ngOnDestroy() {
    if(this.playerClassSubscription) {
      this.playerClassSubscription.unsubscribe();
    }
  }

  subscribeToPlayerClassData() {
    this.playerClassSubscription = this.playerClassService.indexAll().subscribe({
      next: (data) => {
        this.playerClasses = data;
      },
      error: (fail) => {
        console.error('Error retrieving player classes data');
        console.error(fail);
      }
    });
  }

}
