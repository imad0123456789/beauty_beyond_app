import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NotFounComponentComponent } from './not-foun-component.component';

describe('NotFounComponentComponent', () => {
  let component: NotFounComponentComponent;
  let fixture: ComponentFixture<NotFounComponentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NotFounComponentComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(NotFounComponentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
