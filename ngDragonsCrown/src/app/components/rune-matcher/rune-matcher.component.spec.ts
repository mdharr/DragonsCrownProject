import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RuneMatcherComponent } from './rune-matcher.component';

describe('RuneMatcherComponent', () => {
  let component: RuneMatcherComponent;
  let fixture: ComponentFixture<RuneMatcherComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RuneMatcherComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RuneMatcherComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
