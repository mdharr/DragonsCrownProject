import { TestBed } from '@angular/core/testing';

import { ImageProxyService } from './image-proxy.service';

describe('ImageProxyService', () => {
  let service: ImageProxyService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ImageProxyService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
