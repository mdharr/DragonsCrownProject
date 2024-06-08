import { Injectable, inject } from '@angular/core';
import { ToggleStrictModeComponent } from '../components/toggle-strict-mode/toggle-strict-mode.component';
import { MatDialog } from '@angular/material/dialog';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StrictModeService {

  private strictModeEnabled: boolean = true;
  private strictModeSubject = new Subject<boolean>();
  dialog = inject(MatDialog);

  constructor() {
    const savedState = localStorage.getItem('strictModeEnabled');
    this.strictModeEnabled = savedState !== null ? savedState === 'true' : true;
  }

  toggleStrictMode(): void {
    this.strictModeEnabled = !this.strictModeEnabled;
    localStorage.setItem('strictModeEnabled', this.strictModeEnabled.toString());
    this.strictModeSubject.next(this.strictModeEnabled);
  }

  isStrictModeEnabled(): boolean {
    return this.strictModeEnabled;
  }

  getStrictModeObservable() {
    return this.strictModeSubject.asObservable();
  }

  openToggleStrictModeComponent() {
    this.dialog.open(ToggleStrictModeComponent,{
      width: '600px',
      // data: { userList: UserList }
    });
  }
}
