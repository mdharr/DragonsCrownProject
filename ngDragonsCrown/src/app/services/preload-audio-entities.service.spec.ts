import { TestBed } from '@angular/core/testing';

import { PreloadAudioEntitiesService } from './preload-audio-entities.service';

describe('PreloadAudioEntitiesService', () => {
  let service: PreloadAudioEntitiesService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PreloadAudioEntitiesService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
