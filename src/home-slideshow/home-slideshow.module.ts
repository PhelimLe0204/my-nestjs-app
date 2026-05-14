import { Module } from '@nestjs/common';
import { HomeSlideshowController } from './home-slideshow.controller';
import { HomeSlideshowService } from './home-slideshow.service';

@Module({
  controllers: [HomeSlideshowController],
  providers: [HomeSlideshowService],
})
export class HomeSlideshowModule {}
