import { ComponentFixture, TestBed } from '@angular/core/testing';

import { QuestsModalComponent } from './quests-modal.component';

describe('QuestsModalComponent', () => {
  let component: QuestsModalComponent;
  let fixture: ComponentFixture<QuestsModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ QuestsModalComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(QuestsModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
