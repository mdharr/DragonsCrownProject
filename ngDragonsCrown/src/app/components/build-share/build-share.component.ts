import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-build-share',
  templateUrl: './build-share.component.html',
  styleUrls: ['./build-share.component.css']
})
export class BuildShareComponent implements OnInit, OnDestroy {

  // properties
  build: any;
  buildArray: any[] = [];

  // subscriptions
  private paramsSubscription: Subscription | undefined;

  constructor(private activatedRoute: ActivatedRoute) { }

  ngOnInit() {
    window.scrollTo(0, 0);
    this.getRouteParams();
  }

  ngOnDestroy() {
    if (this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
  }

  getRouteParams() {
    this.paramsSubscription = this.activatedRoute.queryParams.subscribe(params => {
      const encodedBuild = params['encodedBuild'];
      if (encodedBuild) {
        const decodedJsonBuild = decodeURIComponent(encodedBuild);
        const buildObject = JSON.parse(decodedJsonBuild);
        this.buildArray = Object.values(buildObject);
      }
    });
  }

  decodeBuild(encodedBuild: string): any {
    const decodedJsonBuild = decodeURIComponent(encodedBuild);
    return JSON.parse(decodedJsonBuild);
  }

}