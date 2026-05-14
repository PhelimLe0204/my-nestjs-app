import { Controller, Get } from '@nestjs/common';
import { HomeSlideshowService } from './home-slideshow.service';
import { HomeSlideshowResponseDto } from './dto/home-slideshow-response.dto';

@Controller('home-slideshow')
export class HomeSlideshowController {
  constructor(private readonly homeSlideshowService: HomeSlideshowService) {}

  @Get()
  async getActiveSlides(): Promise<HomeSlideshowResponseDto[]> {
    return this.homeSlideshowService.getActiveSlides();
  }
}
