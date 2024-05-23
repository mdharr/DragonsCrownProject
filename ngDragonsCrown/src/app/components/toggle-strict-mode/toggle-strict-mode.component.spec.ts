import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ToggleStrictModeComponent } from './toggle-strict-mode.component';

describe('ToggleStrictModeComponent', () => {
  let component: ToggleStrictModeComponent;
  let fixture: ComponentFixture<ToggleStrictModeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ToggleStrictModeComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ToggleStrictModeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
