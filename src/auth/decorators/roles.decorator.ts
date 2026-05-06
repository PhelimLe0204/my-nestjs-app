import { SetMetadata } from '@nestjs/common';
import { Role } from '@prisma/client';

export const ROLES_KEY = 'roles';

// Dùng @Roles(Role.ADMIN) để chỉ cho phép ADMIN truy cập
export const Roles = (...roles: Role[]) => SetMetadata(ROLES_KEY, roles);
