import { TestBed } from '@angular/core/testing';

import { QuestsService } from './quests.service';

describe('QuestsService', () => {
  let service: QuestsService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(QuestsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
