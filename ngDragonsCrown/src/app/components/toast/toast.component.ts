import { Component } from '@angular/core';
import { ToastService } from 'src/app/services/toast.service';

@Component({
  selector: 'app-toast',
  templateUrl: './toast.component.html',
  styleUrls: ['./toast.component.css']
})
export class ToastComponent {
  message: string = '';

  constructor(private toastService: ToastService) {}

  ngOnInit(): void {
    this.toastService.display$.subscribe(msg => {
      this.message = msg;
    });
  }
}
