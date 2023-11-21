import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class AuthService {

    constructor(
        private usersService: UsersService,
        private jwtService: JwtService
    ) { }

    async signIn(username: string, pass: string): Promise<any> {
        const user = await this.usersService.findOne(username);
        if (user?.password !== pass) {
            // throw new UnauthorizedException();
            return;
        }
        const payload = { sub: user.userIndex, username: user.firstName };
        user.lastLoginDate = new Date()
        let updateObj = { ...user }
        if (updateObj.credits) delete updateObj.credits
        this.usersService.update(user.userIndex, updateObj)
        return {
            access_token: await this.jwtService.signAsync(payload),
            user: user
        };
    }



}

