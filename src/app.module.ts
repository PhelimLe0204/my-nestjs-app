import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { APP_GUARD } from '@nestjs/core';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { JwtAuthGuard } from './auth/guards/jwt-auth.guard';
import { RolesGuard } from './auth/guards/roles.guard';
import { HomeSlideshowModule } from './home-slideshow/home-slideshow.module';

@Module({
  imports: [PrismaModule, AuthModule, UsersModule, HomeSlideshowModule],
  controllers: [AppController],
  providers: [
    AppService,
    // Áp dụng JwtAuthGuard cho TOÀN BỘ route
    // Route nào không cần login thì thêm @Public()
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
    // Áp dụng RolesGuard cho TOÀN BỘ route
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    },
  ],
})
export class AppModule {}
