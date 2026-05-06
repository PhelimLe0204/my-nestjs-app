import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Role } from '@prisma/client';
import { ROLES_KEY } from '../decorators/roles.decorator';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    // Lấy danh sách role được phép từ decorator
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    // Không có @Roles() thì cho qua
    if (!requiredRoles) return true;

    // Kiểm tra role của user hiện tại
    // Fix: ép kiểu rõ ràng cho request
    const request = context
      .switchToHttp()
      .getRequest<{ user: { role: Role } }>();
    return requiredRoles.includes(request.user.role);
  }
}
