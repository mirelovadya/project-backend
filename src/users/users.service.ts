import { Injectable } from '@nestjs/common';
import { UpdateUserDto, UserDto } from 'src/dto/user-dto';
import { PrismaService } from 'src/prisma/prisma.service';

export type User = any;

@Injectable()
export class UsersService {
    constructor(private prisma: PrismaService) { }

    async create(newUser: any) {
        let user = await this.prisma.users.create({
            data: newUser
        })
        return user;
    }

    async findOne(firstName: string): Promise<User | undefined> {
        let user = await this.prisma.users.findFirst({
            where: { firstName: firstName },
            include: {
                credits: true
            }
        })
        return user;
    }

    async findOneById(id: number): Promise<User | undefined> {
        let user = await this.prisma.users.findFirst({
            where: { userIndex: id }
        })
        return user;
    }

    async findAll() {
        let users = await this.prisma.users.findMany()
        return users;
    }

    async update(id: any, user: UpdateUserDto) {
        let userAfterUpdate = await this.prisma.users.update({
            where: { userIndex: id },
            data: user
        })
        return userAfterUpdate;
    }

    async remove(id: any) {
        let userAfterDelete = await this.prisma.users.delete({
            where: { userIndex: id }
        })
        return userAfterDelete;
    }


}
