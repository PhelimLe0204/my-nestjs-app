import { SetMetadata } from '@nestjs/common';

export const IS_PUBLIC_KEY = 'isPublic';

// Dùng @Public() để đánh dấu route không cần đăng nhập
// Ví dụ: trang chủ, trang tin tức, form liên hệ
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);
