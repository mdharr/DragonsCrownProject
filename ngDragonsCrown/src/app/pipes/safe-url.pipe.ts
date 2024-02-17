import { Pipe, PipeTransform } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

@Pipe({
  name: 'safeUrl'
})
export class SafeUrlPipe implements PipeTransform {

  constructor(private sanitizer: DomSanitizer) {}

  transform(url: string): SafeResourceUrl {
    // Append query parameters for autoplay and no controls
    const safeUrl = url + '?autoplay=1&loop=0';
    return this.sanitizer.bypassSecurityTrustResourceUrl(safeUrl);
  }

}

// <iframe width="1440" height="645" src="https://www.youtube.com/embed/d1hzfXiWIaA" title="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
