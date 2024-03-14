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

  // injections
  activatedRoute = inject(ActivatedRoute);

  // subscriptions
  private paramsSubscription: Subscription | undefined;

  ngOnInit() {
    window.scrollTo(0, 0);
    this.getRouteParams();
  }

  ngOnDestroy() {
    if(this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
  }

  getRouteParams = () => {
    this.paramsSubscription = this.activatedRoute.paramMap.subscribe(
      (params: ParamMap) => {
        let idString = params.get('encodedBuild');
        if (idString) {
          console.log(idString);
        }
      }
    );
  };
}
