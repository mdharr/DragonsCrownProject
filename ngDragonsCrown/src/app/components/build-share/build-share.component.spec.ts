import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BuildShareComponent } from './build-share.component';

describe('BuildShareComponent', () => {
  let component: BuildShareComponent;
  let fixture: ComponentFixture<BuildShareComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BuildShareComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BuildShareComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
