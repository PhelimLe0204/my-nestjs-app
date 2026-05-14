export class HomeSlideshowResponseDto {
  id!: string;
  titleVi!: string;
  titleEn!: string | null;
  subtitleVi!: string | null;
  subtitleEn!: string | null;
  ctaVi!: string | null;
  ctaEn!: string | null;
  imageUrl!: string;
  linkUrl!: string | null;
  order!: number;
}
