import { Component, EventEmitter, Input, Output, OnInit } from '@angular/core';
import { Quest } from 'src/app/models/quest';

@Component({
  selector: 'app-quest-modal',
  templateUrl: './quest-modal.component.html',
  styleUrls: ['./quest-modal.component.css']
})
export class QuestModalComponent implements OnInit {
  @Input() quests: Quest[] = [];
  @Output() close = new EventEmitter<void>();
  @Output() questToggle = new EventEmitter<Quest>();

  ngOnInit() {
    console.log(this.quests);
  }

  isQuestSelected(quest: Quest): boolean {
    // Implement the logic to determine if a quest is selected
    return false; // Placeholder return
  }

  calculateTotalSkillPoints(): number {
    // Sum the skillPoints of all selected quests
    return this.quests.filter(quest => quest.selected).reduce((total, quest) => total + quest.skillPoints, 0);
  }

  // Make sure your method to toggle quest selection updates the `selected` property of each quest
  toggleQuest(quest: Quest): void {
    quest.selected = !quest.selected; // Toggle the selected state
    this.questToggle.emit(quest); // If you're still emitting this for parent components to handle
  }

  closeModal(): void {
    this.close.emit();
  }

  // Adjust the method to accept a generic Event parameter
  toggleAllQuests(event: Event): void {
    const target = event.target as HTMLInputElement; // Perform the type assertion here
    const selected = target.checked;
    this.quests.forEach(quest => {
      quest.selected = selected;
      this.questToggle.emit(quest); // Emit changes for each quest
    });
  }

  areAllQuestsSelected(): boolean {
    return this.quests.every(quest => quest.selected);
  }

}
