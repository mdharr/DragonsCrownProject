import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BuildShareComponent } from './components/build-share/build-share.component';
import { HomeComponent } from './components/home/home.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'build/:buildId', component: BuildShareComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
