-- CreateTable
CREATE TABLE `tbl_user` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    `username` VARCHAR(20) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `tbl_user_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mst_rekening_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    `description` TINYTEXT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_rekening` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `typeId` INTEGER NOT NULL,
    `name` VARCHAR(40) NOT NULL,
    `description` TINYTEXT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mst_transaction_status` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    `type` ENUM('income', 'expense') NOT NULL,
    `color` CHAR(7) NOT NULL,
    `description` TINYTEXT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `trs_transaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `statusId` INTEGER NOT NULL,
    `type` ENUM('income', 'expense') NOT NULL,
    `rekeningId` INTEGER NOT NULL,
    `balace` BIGINT NOT NULL,
    `amount` BIGINT NOT NULL,
    `description` TINYTEXT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_debt` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `name` VARCHAR(80) NOT NULL,
    `type` ENUM('kredit', 'debit') NOT NULL,
    `status` ENUM('aktif', 'pending', 'paid', 'overdue') NOT NULL,
    `amount` BIGINT NOT NULL,
    `description` TINYTEXT NULL,
    `dueDate` DATE NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `trs_debt_installment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `debtId` INTEGER NOT NULL,
    `type` ENUM('kredit', 'debit') NOT NULL,
    `amount` BIGINT NOT NULL,
    `dueDate` DATE NOT NULL,
    `status` ENUM('pending', 'process', 'paid', 'overdue') NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `trs_debt_transaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `debtId` INTEGER NOT NULL,
    `transactionId` INTEGER NOT NULL,
    `installmentId` INTEGER NOT NULL,
    `type` ENUM('kredit', 'debit') NOT NULL,
    `amount` BIGINT NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `tbl_rekening` ADD CONSTRAINT `tbl_rekening_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `tbl_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tbl_rekening` ADD CONSTRAINT `tbl_rekening_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `mst_rekening_type`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_transaction` ADD CONSTRAINT `trs_transaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `tbl_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_transaction` ADD CONSTRAINT `trs_transaction_statusId_fkey` FOREIGN KEY (`statusId`) REFERENCES `mst_transaction_status`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_transaction` ADD CONSTRAINT `trs_transaction_rekeningId_fkey` FOREIGN KEY (`rekeningId`) REFERENCES `tbl_rekening`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tbl_debt` ADD CONSTRAINT `tbl_debt_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `tbl_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_debt_installment` ADD CONSTRAINT `trs_debt_installment_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `tbl_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_debt_installment` ADD CONSTRAINT `trs_debt_installment_debtId_fkey` FOREIGN KEY (`debtId`) REFERENCES `tbl_debt`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_debt_transaction` ADD CONSTRAINT `trs_debt_transaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `tbl_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_debt_transaction` ADD CONSTRAINT `trs_debt_transaction_debtId_fkey` FOREIGN KEY (`debtId`) REFERENCES `tbl_debt`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_debt_transaction` ADD CONSTRAINT `trs_debt_transaction_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `trs_transaction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `trs_debt_transaction` ADD CONSTRAINT `trs_debt_transaction_installmentId_fkey` FOREIGN KEY (`installmentId`) REFERENCES `trs_debt_installment`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
