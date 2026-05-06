import { Global, Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Global() // ← Quan trọng! Global để không cần import lại ở mọi module
@Module({
  providers: [PrismaService],
  exports: [PrismaService],
})
export class PrismaModule {}
