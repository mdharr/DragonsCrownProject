import { Injectable } from '@angular/core';
import { AudioEntity } from '../models/audio-entity';

@Injectable({
  providedIn: 'root'
})
export class PreloadAudioEntitiesService {

  private audioContext = new AudioContext();

  constructor() {}

  async preloadAudio(...audioEntityArrays: AudioEntity[][]): Promise<void> {
    // Flatten all arrays into a single array
    const allAudioEntities = audioEntityArrays.flat();
    const promises = allAudioEntities.map(audio => this.loadAudio(audio.path));
    await Promise.all(promises);
    console.log('All audio files preloaded');
  }

  private async loadAudio(path: string): Promise<void> {
    const response = await fetch(path);
    const arrayBuffer = await response.arrayBuffer();
    await this.audioContext.decodeAudioData(arrayBuffer);
    console.log(`Preloaded: ${path}`);
  }
}
