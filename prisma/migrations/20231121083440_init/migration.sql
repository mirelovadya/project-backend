-- CreateTable
CREATE TABLE `users` (
    `userIndex` INTEGER NOT NULL AUTO_INCREMENT,
    `firstName` TEXT NOT NULL,
    `lastName` TEXT NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` TEXT NOT NULL,
    `lastLoginDate` DATETIME(0) NULL,

    UNIQUE INDEX `email_field_UNIQUE`(`email`),
    PRIMARY KEY (`userIndex`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `address` (
    `addressIndex` INTEGER NOT NULL AUTO_INCREMENT,
    `city` TEXT NOT NULL,
    `country` TEXT NOT NULL,
    `street` TEXT NOT NULL,
    `houseNumber` TEXT NOT NULL,
    `zip` TEXT NULL,
    `defaultAddress` BOOLEAN NOT NULL DEFAULT false,
    `userIndex` INTEGER NOT NULL,

    PRIMARY KEY (`addressIndex`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `productIndex` INTEGER NOT NULL AUTO_INCREMENT,
    `name` TEXT NOT NULL,
    `barcode` TEXT NOT NULL,
    `price` DOUBLE NOT NULL,
    `image` LONGTEXT NULL,
    `orderIndex` INTEGER NULL,

    PRIMARY KEY (`productIndex`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders` (
    `orderIndex` INTEGER NOT NULL AUTO_INCREMENT,
    `orderDate` DATETIME(0) NULL,
    `price` DOUBLE NOT NULL,
    `userIndex` INTEGER NOT NULL,

    PRIMARY KEY (`orderIndex`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment` (
    `paymentIndex` INTEGER NOT NULL AUTO_INCREMENT,
    `orderIndex` INTEGER NOT NULL,
    `userIndex` INTEGER NOT NULL,
    `creditIndex` INTEGER NULL,

    UNIQUE INDEX `payment_orderIndex_key`(`orderIndex`),
    PRIMARY KEY (`paymentIndex`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Credit` (
    `creditIndex` INTEGER NOT NULL AUTO_INCREMENT,
    `creditNumber` VARCHAR(191) NOT NULL,
    `creditDate` DATETIME(0) NOT NULL,
    `creditCvv` INTEGER NOT NULL,
    `defaultCredit` BOOLEAN NOT NULL DEFAULT false,
    `userIndex` INTEGER NOT NULL,

    UNIQUE INDEX `credit_namber_UNIQUE`(`creditNumber`),
    PRIMARY KEY (`creditIndex`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_OrdersToProducts` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_OrdersToProducts_AB_unique`(`A`, `B`),
    INDEX `_OrdersToProducts_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `address` ADD CONSTRAINT `address_userIndex_fkey` FOREIGN KEY (`userIndex`) REFERENCES `users`(`userIndex`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders` ADD CONSTRAINT `orders_userIndex_fkey` FOREIGN KEY (`userIndex`) REFERENCES `users`(`userIndex`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payment` ADD CONSTRAINT `payment_orderIndex_fkey` FOREIGN KEY (`orderIndex`) REFERENCES `orders`(`orderIndex`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payment` ADD CONSTRAINT `payment_userIndex_fkey` FOREIGN KEY (`userIndex`) REFERENCES `users`(`userIndex`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payment` ADD CONSTRAINT `payment_creditIndex_fkey` FOREIGN KEY (`creditIndex`) REFERENCES `Credit`(`creditIndex`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Credit` ADD CONSTRAINT `Credit_userIndex_fkey` FOREIGN KEY (`userIndex`) REFERENCES `users`(`userIndex`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_OrdersToProducts` ADD CONSTRAINT `_OrdersToProducts_A_fkey` FOREIGN KEY (`A`) REFERENCES `orders`(`orderIndex`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_OrdersToProducts` ADD CONSTRAINT `_OrdersToProducts_B_fkey` FOREIGN KEY (`B`) REFERENCES `products`(`productIndex`) ON DELETE CASCADE ON UPDATE CASCADE;
