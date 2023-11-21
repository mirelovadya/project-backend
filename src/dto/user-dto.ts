export class UserDto {
    firstName: string;
    lastName: string;
    email: string;
    password: string;
    lastLoginDate: Date;
    credits: [];
}

export class UpdateUserDto {
    firstName: string;
    lastName: string;
    email: string;
    password: string;
    lastLoginDate: Date;
}
