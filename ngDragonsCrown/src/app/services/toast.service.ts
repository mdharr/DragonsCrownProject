import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ToastService {

  private display = new BehaviorSubject<string>('');

  display$ = this.display.asObservable();

  constructor() {}

  show(message: string): void {
    this.display.next(message);
    setTimeout(() => this.display.next(''), 1000);  // Toast message will disappear after 3000 ms
  }
}
