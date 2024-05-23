import { Injectable } from '@angular/core';
import { CustomSnackbarComponent } from '../components/custom-snackbar/custom-snackbar.component';
import { MatSnackBar } from '@angular/material/snack-bar';

@Injectable({
  providedIn: 'root'
})
export class SnackbarService {

  constructor(private snackBar: MatSnackBar) {}

  openSnackbar(message: string, action?: string, className?: string, duration: number = 6000) {
    this.snackBar.openFromComponent(CustomSnackbarComponent, {
      duration: duration,
      data: { message: message, action: action, className: className?.toLowerCase() }
    });
  }
}
