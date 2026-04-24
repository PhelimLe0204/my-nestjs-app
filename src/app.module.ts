import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { SlideshowModule } from './slideshow/slideshow.module';

@Module({
  imports: [SlideshowModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
