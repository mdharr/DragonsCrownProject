import { TestBed } from '@angular/core/testing';

import { StrictModeService } from './strict-mode.service';

describe('StrictModeService', () => {
  let service: StrictModeService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(StrictModeService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
