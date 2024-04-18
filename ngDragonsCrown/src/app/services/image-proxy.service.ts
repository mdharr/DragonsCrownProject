import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { firstValueFrom } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ImageProxyService {
  // private baseUrl = environment.baseUrl + 'api/proxy/image?url=';

  // constructor(private http: HttpClient) { }

  // async fetchImageAsDataURL(url: string): Promise<string> {
  //   // Use encodeURIComponent to ensure the URL is correctly encoded for a query parameter
  //   const encodedUrl = encodeURIComponent(url);

  //   // Fetch the blob from the server-side proxy
  //   const blob = await firstValueFrom(this.http.get(`${this.baseUrl}${encodedUrl}`, { responseType: 'blob' }));

  //   // Convert the Blob to a data URL
  //   return new Promise((resolve, reject) => {
  //     const reader = new FileReader();
  //     reader.onloadend = () => {
  //       if (typeof reader.result === 'string') {
  //         resolve(reader.result);
  //       } else {
  //         reject(new Error('Failed to load image'));
  //       }
  //     };
  //     reader.onerror = () => reject(new Error('Error reading blob as data URL'));
  //     reader.readAsDataURL(blob);
  //   });
  // }

}
