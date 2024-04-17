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
    // console.log('All audio files preloaded');
  }

  private async loadAudio(path: string): Promise<void> {
    try {
      const response = await fetch(path);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const arrayBuffer = await response.arrayBuffer();
      await this.audioContext.decodeAudioData(arrayBuffer, (buffer) => {
        // console.log(`Preloaded: ${path}`);
      }, (error) => {
        console.error(`Error decoding audio data: ${error}`);
      });
    } catch (error) {
      console.error(`Error loading audio from path: ${path}`, error);
    }
  }

}
