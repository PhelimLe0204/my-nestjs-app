import {
  Injectable,
  UnauthorizedException,
  BadRequestException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { UsersService } from '../users/users.service';
import { LoginDto } from './dto/login.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import { User } from '@prisma/client';

// Fix: định nghĩa kiểu rõ ràng cho JWT payload
interface JwtPayload {
  sub: string;
  email: string;
  role: string;
}

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  // ── Đăng nhập ──────────────────────────────────────────────────────────
  async login(dto: LoginDto) {
    // 1. Tìm user theo email
    const user = await this.usersService.findByEmail(dto.email);
    if (!user) {
      throw new UnauthorizedException('Email hoặc mật khẩu không đúng');
    }

    // 2. Kiểm tra tài khoản có bị khoá không
    if (!user.isActive) {
      throw new UnauthorizedException('Tài khoản đã bị khoá');
    }

    // 3. So sánh mật khẩu
    const isPasswordValid = await bcrypt.compare(
      dto.password,
      user.passwordHash,
    );
    if (!isPasswordValid) {
      throw new UnauthorizedException('Email hoặc mật khẩu không đúng');
    }

    // 4. Tạo token
    const tokens = await this.generateTokens(user);
    return {
      ...tokens,
      user: {
        id: user.id,
        email: user.email,
        fullName: user.fullName,
        role: user.role,
      },
    };
  }

  // ── Refresh Token ───────────────────────────────────────────────────────
  async refreshToken(refreshToken: string) {
    try {
      // Fix: ép kiểu rõ ràng JwtPayload cho payload
      const payload = this.jwtService.verify<JwtPayload>(refreshToken, {
        secret: process.env.JWT_REFRESH_SECRET,
      });
      const user = await this.usersService.findById(payload.sub);
      if (!user || !user.isActive) {
        throw new UnauthorizedException();
      }
      return this.generateTokens(user);
    } catch {
      throw new UnauthorizedException(
        'Refresh token không hợp lệ hoặc đã hết hạn',
      );
    }
  }

  // ── Đổi mật khẩu ───────────────────────────────────────────────────────
  async changePassword(userId: string, dto: ChangePasswordDto) {
    const user = await this.usersService.findById(userId);

    // Fix: kiểm tra null trước khi dùng
    if (!user) {
      throw new UnauthorizedException('Không tìm thấy tài khoản');
    }

    // Kiểm tra mật khẩu hiện tại
    const isValid = await bcrypt.compare(
      dto.currentPassword,
      user.passwordHash,
    );
    if (!isValid) {
      throw new BadRequestException('Mật khẩu hiện tại không đúng');
    }

    // Mã hoá mật khẩu mới
    const hashedPassword = await bcrypt.hash(dto.newPassword, 10);
    await this.usersService.updatePassword(userId, hashedPassword);

    return { message: 'Đổi mật khẩu thành công' };
  }

  // ── Helper: Tạo cặp Access + Refresh Token ─────────────────────────────
  private async generateTokens(user: User) {
    const payload = {
      sub: user.id, // subject = id của user
      email: user.email,
      role: user.role,
    };

    const [accessToken, refreshToken] = await Promise.all([
      // Access Token: hết hạn sau 15 phút
      this.jwtService.signAsync(payload, {
        secret: process.env.JWT_SECRET,
        expiresIn: '15m',
      }),
      // Refresh Token: hết hạn sau 7 ngày
      this.jwtService.signAsync(payload, {
        secret: process.env.JWT_REFRESH_SECRET,
        expiresIn: '7d',
      }),
    ]);

    return { accessToken, refreshToken };
  }
}
