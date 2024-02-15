import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { PlayerClass } from '../models/player-class';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PlayerClassService {
  private url = environment.baseUrl + 'api/classes';

  http = inject(HttpClient);
  authService = inject(AuthService);

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authService.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  indexAll(): Observable<PlayerClass[]> {
    return this.http.get<PlayerClass[]>(`${this.url}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
          new Error('PlayerClassService.indexAll(): error retrieving list of player classes' + err)
        );
      })
    );
  }
}