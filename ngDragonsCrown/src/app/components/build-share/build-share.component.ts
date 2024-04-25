import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription, takeUntil } from 'rxjs';
import { PlayerClass } from 'src/app/models/player-class';
import { PlayerClassService } from 'src/app/services/player-class.service';

@Component({
  selector: 'app-build-share',
  templateUrl: './build-share.component.html',
  styleUrls: ['./build-share.component.css']
})
export class BuildShareComponent implements OnInit, OnDestroy {

  // properties
  build: any;
  buildArray: any[] = [];
  classId: number = 0;
  // playerClass: PlayerClass = new PlayerClass();
  playerClassImageUrl: string = '';

  // subscriptions
  private paramsSubscription: Subscription | undefined;
  private classSubscription: Subscription | undefined;

  // injections
  private activatedRoute = inject(ActivatedRoute);
  private playerClassService = inject(PlayerClassService);

  ngOnInit() {
    window.scrollTo(0, 0);
    this.getRouteParams();
    this.subscribeToClass(this.classId);
  }

  ngOnDestroy() {
    if (this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
    if (this.classSubscription) {
      this.classSubscription.unsubscribe();
    }
  }

  getRouteParams() {
    this.paramsSubscription = this.activatedRoute.queryParams.subscribe(params => {
      const encodedBuild = params['encodedBuild'];
      const classId = params['classId'];
      if (encodedBuild && classId) {
        const decodedJsonBuild = decodeURIComponent(encodedBuild);
        const buildObject = JSON.parse(decodedJsonBuild);
        this.buildArray = Object.values(buildObject);
        this.classId = +classId;
        console.log('Class ID:', this.classId);
      }
    });
  }

  decodeBuild(encodedBuild: string): any {
    const decodedJsonBuild = decodeURIComponent(encodedBuild);
    return JSON.parse(decodedJsonBuild);
  }

  subscribeToClass(id: number) {
    this.playerClassService.find(id).subscribe({
      next: (data) => {
        this.playerClassImageUrl = data.alternateArtUrl;
      },
      error: (fail) => {
        console.error('Error retrieving player classes data');
        console.error(fail);
      }
    });
  }

}
