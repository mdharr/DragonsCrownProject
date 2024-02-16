import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IntroTooltipComponent } from './intro-tooltip.component';

describe('IntroTooltipComponent', () => {
  let component: IntroTooltipComponent;
  let fixture: ComponentFixture<IntroTooltipComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ IntroTooltipComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(IntroTooltipComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
