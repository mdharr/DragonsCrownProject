import { Injectable, inject } from '@angular/core';
import { ToggleStrictModeComponent } from '../components/toggle-strict-mode/toggle-strict-mode.component';
import { MatDialog } from '@angular/material/dialog';

@Injectable({
  providedIn: 'root'
})
export class StrictModeService {

  private strictModeEnabled: boolean = true;
  dialog = inject(MatDialog);

  constructor() {
    const savedState = localStorage.getItem('strictModeEnabled');
    this.strictModeEnabled = savedState !== null ? savedState === 'true' : true;
  }

  toggleStrictMode(): void {
    this.strictModeEnabled = !this.strictModeEnabled;
    localStorage.setItem('strictModeEnabled', this.strictModeEnabled.toString());
  }

  isStrictModeEnabled(): boolean {
    return this.strictModeEnabled;
  }
  openToggleStrictModeComponent() {
    this.dialog.open(ToggleStrictModeComponent,{
      width: '400px',
      // data: { userList: UserList }
    });
  }
}
