import { ComponentFixture, TestBed } from '@angular/core/testing';

import { QuestModalComponent } from './quest-modal.component';

describe('QuestModalComponent', () => {
  let component: QuestModalComponent;
  let fixture: ComponentFixture<QuestModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ QuestModalComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(QuestModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
