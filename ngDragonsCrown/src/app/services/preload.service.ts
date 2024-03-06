import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PreloadService {
  preloadImage(url: string): Observable<string> {
    const subject = new Subject<string>();

    const img = new Image();
    img.onload = () => {
      subject.next(url);
      subject.complete();
    };
    img.onerror = (error) => {
      subject.error(`Failed to load image ${url}`);
    };
    img.src = url;

    return subject.asObservable();
  }
}
