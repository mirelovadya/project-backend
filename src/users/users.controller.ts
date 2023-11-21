import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { UsersService } from './users.service';
import { UpdateUserDto, UserDto } from 'src/dto/user-dto';
import { Public } from 'src/auth/auth.guard';

@Controller('users')
export class UsersController {
    constructor(private readonly usersService: UsersService) { }

    @Post()
    create(@Body() createUserDto: UserDto) {
        return this.usersService.create(createUserDto);
    }

    @Get()
    findAll() {
        return this.usersService.findAll();
    }

    @Public()
    @Get(':id')
    async findOne(@Param('id') id: string) {
        return await this.usersService.findOne(id);
    }

    @Patch(':id')
    update(@Param('id') id: any, @Body() updateCustomerDto: UpdateUserDto) {
        return this.usersService.update(id, updateCustomerDto);
    }

    @Delete(':id')
    remove(@Param('id') id: any) {
        return this.usersService.remove(id);
    }
}
