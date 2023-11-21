import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ProductsService {
    constructor(private prisma: PrismaService) { }


    async findAll() {
        let products = await this.prisma.products.findMany()
        return products;
    }

}
