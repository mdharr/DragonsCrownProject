import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';
import { PlayerClassService } from 'src/app/services/player-class.service';

import * as pako from 'pako';

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

  // getRouteParams() {
  //   this.paramsSubscription = this.activatedRoute.queryParams.subscribe(params => {
  //     const encodedBuild = params['encodedBuild'];
  //     const classId = params['classId'];
  //     if (encodedBuild && classId) {
  //       const decodedJsonBuild = decodeURIComponent(encodedBuild);
  //       const buildObject = JSON.parse(decodedJsonBuild);
  //       this.buildArray = Object.values(buildObject);
  //       this.classId = +classId;
  //       console.log('Class ID:', this.classId);
  //     }
  //   });
  // }

  getRouteParams() {
    this.paramsSubscription = this.activatedRoute.queryParams.subscribe(params => {
      const encodedBuild = params['encodedBuild'];
      const classId = params['classId'];
      if (encodedBuild && classId) {
        const decodedBuild = this.decodeBuild(encodedBuild); // Call decodeBuild method
        if (decodedBuild) {
          this.buildArray = Object.values(decodedBuild);
          this.classId = +classId;
          console.log('Class ID:', this.classId);
        } else {
          console.error('Error decoding or parsing build data.');
        }
      }
    });
  }


  // decodeBuild(encodedBuild: string): any {
  //   const decodedJsonBuild = decodeURIComponent(encodedBuild);
  //   return JSON.parse(decodedJsonBuild);
  // }

  decodeBuild(encodedBuild: string): any {
    try {
      // Decode URL component
      const decodedData = decodeURIComponent(encodedBuild);

      // Decode base64 data
      const decodedBase64Data = atob(decodedData);

      // Convert base64 decoded string to Uint8Array
      const byteArray = new Uint8Array(decodedBase64Data.length);
      for (let i = 0; i < decodedBase64Data.length; i++) {
        byteArray[i] = decodedBase64Data.charCodeAt(i);
      }

      // Decompress the data using Pako
      const decompressedData = pako.inflate(byteArray, { to: 'string' });

      // Parse the decompressed JSON string
      const parsedData = JSON.parse(decompressedData);

      console.log('Decoded and parsed data:', parsedData);

      return parsedData;
    } catch (error) {
      console.error('Error decoding or parsing build data:', error);
      return null; // Return null or handle the error as needed
    }
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
