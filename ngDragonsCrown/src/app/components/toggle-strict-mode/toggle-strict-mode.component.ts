import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { SnackbarService } from 'src/app/services/snackbar.service';
import { StrictModeService } from 'src/app/services/strict-mode.service';

@Component({
  selector: 'app-toggle-strict-mode',
  templateUrl: './toggle-strict-mode.component.html',
  styleUrls: ['./toggle-strict-mode.component.css']
})
export class ToggleStrictModeComponent {

    constructor(
      private dialogRef: MatDialogRef<ToggleStrictModeComponent>,
      @Inject(MAT_DIALOG_DATA) private data: any,
      private strictModeService: StrictModeService,
      private snackbarService: SnackbarService
    ) {}

    toggleStrictMode() {
      this.strictModeService.toggleStrictMode();
      this.closeDialog();
    }

    closeDialog() {
      this.dialogRef.close();
    }

    openSnackbar(message: string, action: string) {
      this.snackbarService.openSnackbar(message, action);
    }

    isStrictModeActive() {
      return this.strictModeService.isStrictModeEnabled();
    }
}
