import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SampleVoiceComponent } from './sample-voice.component';

describe('SampleVoiceComponent', () => {
  let component: SampleVoiceComponent;
  let fixture: ComponentFixture<SampleVoiceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SampleVoiceComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SampleVoiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
