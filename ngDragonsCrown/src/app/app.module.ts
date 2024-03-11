import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { MatIconModule } from '@angular/material/icon';
import { MatMenuModule } from '@angular/material/menu';
import { MatButtonModule } from '@angular/material/button';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDialogModule } from '@angular/material/dialog';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './components/home/home.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ScrollToTopButtonComponent } from './components/scroll-to-top-button/scroll-to-top-button.component';
import { SafeUrlPipe } from './pipes/safe-url.pipe';
import { NavbarComponent } from './components/navbar/navbar.component';
import { CardPlaceholderComponent } from './components/card-placeholder/card-placeholder.component';
import { SpriteAnimationComponent } from './components/sprite-animation/sprite-animation.component';
import { CalculateTotalSPPipe } from './pipes/calculate-total-s-p.pipe';
import { ParticlesComponent } from './components/particles/particles.component';
import { RuneMatcherComponent } from './components/rune-matcher/rune-matcher.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    ScrollToTopButtonComponent,
    SafeUrlPipe,
    NavbarComponent,
    CardPlaceholderComponent,
    SpriteAnimationComponent,
    CalculateTotalSPPipe,
    ParticlesComponent,
    RuneMatcherComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    NgbModule,
    MatIconModule,
    MatButtonModule,
    MatTooltipModule,
    MatDialogModule,
    MatMenuModule,
    BrowserAnimationsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
