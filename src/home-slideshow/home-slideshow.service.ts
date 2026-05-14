import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { HomeSlideshowResponseDto } from './dto/home-slideshow-response.dto';

@Injectable()
export class HomeSlideshowService {
  constructor(private readonly prisma: PrismaService) {}

  async getActiveSlides(): Promise<HomeSlideshowResponseDto[]> {
    const slides = await this.prisma.homeSlideshow.findMany({
      where: { isActive: true },
      orderBy: { order: 'asc' },
      select: {
        id: true,
        titleVi: true,
        titleEn: true,
        subtitleVi: true,
        subtitleEn: true,
        ctaVi: true,
        ctaEn: true,
        imageUrl: true,
        linkUrl: true,
        order: true,
      },
    });

    return slides;
  }
}
