import { Controller, Get } from '@nestjs/common';
import { SlideshowService } from './slideshow.service';

@Controller('slideshow')
export class SlideshowController {
  constructor(private slideshowService: SlideshowService) {}

  @Get()
  getAllSlideshows() {
    return this.slideshowService.getAll();
  }
}
