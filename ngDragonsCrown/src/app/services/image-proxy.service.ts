import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ImageProxyService {

  constructor(private http: HttpClient) { }

  // Method to fetch the image through the proxy
  fetchImageAsDataURL(url: string): Observable<string> {
    return this.http.get<string>(`/api/proxy/image?url=${encodeURIComponent(url)}`, { responseType: 'text' as 'json' });
  }

}
