import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { UsersService } from '../../users/users.service';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private usersService: UsersService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      // Fix: dùng non-null assertion vì biến này chắc chắn có trong .env
      secretOrKey: process.env.JWT_SECRET as string,
    });
  }

  // Hàm này chạy sau khi token hợp lệ
  // Kết quả trả về sẽ được gắn vào request.user
  async validate(payload: { sub: string; email: string; role: string }) {
    const user = await this.usersService.findById(payload.sub);
    if (!user || !user.isActive) {
      throw new UnauthorizedException(
        'Tài khoản không tồn tại hoặc đã bị khoá',
      );
    }
    return user; // → request.user = user
  }
}
