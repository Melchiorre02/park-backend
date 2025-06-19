/*
  Warnings:

  - The primary key for the `Attraction` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `AttractionMap` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Show` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `ShowMap` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Planner` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Ticket` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `rating` on table `Attraction` required. This step will fail if there are existing NULL values in that column.
  - Made the column `popularity` on table `Attraction` required. This step will fail if there are existing NULL values in that column.
  - Made the column `views` on table `Attraction` required. This step will fail if there are existing NULL values in that column.
  - Made the column `likes` on table `Attraction` required. This step will fail if there are existing NULL values in that column.
  - Made the column `status` on table `Attraction` required. This step will fail if there are existing NULL values in that column.
  - Made the column `image` on table `Attraction` required. This step will fail if there are existing NULL values in that column.
  - Made the column `rating` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Made the column `popularity` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Made the column `views` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Made the column `likes` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Made the column `status` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Made the column `image` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Made the column `nextShow` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Made the column `capacity` on table `Show` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Planner` DROP FOREIGN KEY `Planner_userId_fkey`;

-- DropForeignKey
ALTER TABLE `Ticket` DROP FOREIGN KEY `Ticket_userId_fkey`;

-- AlterTable
ALTER TABLE `Attraction` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `rating` DOUBLE NOT NULL,
    MODIFY `popularity` INTEGER NOT NULL,
    MODIFY `views` INTEGER NOT NULL,
    MODIFY `likes` INTEGER NOT NULL,
    MODIFY `status` VARCHAR(191) NOT NULL,
    MODIFY `image` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `AttractionMap` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Show` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `times` VARCHAR(191) NOT NULL,
    MODIFY `rating` DOUBLE NOT NULL,
    MODIFY `popularity` INTEGER NOT NULL,
    MODIFY `views` INTEGER NOT NULL,
    MODIFY `likes` INTEGER NOT NULL,
    MODIFY `status` VARCHAR(191) NOT NULL,
    MODIFY `image` VARCHAR(191) NOT NULL,
    MODIFY `nextShow` VARCHAR(191) NOT NULL,
    MODIFY `capacity` INTEGER NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `ShowMap` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `User` DROP PRIMARY KEY,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `mustChangePassword` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `profileImg` VARCHAR(191) NULL,
    ADD COLUMN `role` VARCHAR(191) NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- DropTable
DROP TABLE `Planner`;

-- DropTable
DROP TABLE `Ticket`;

-- CreateTable
CREATE TABLE `Abbonamento` (
    `id` VARCHAR(191) NOT NULL,
    `tipo` VARCHAR(191) NOT NULL,
    `inizio` DATETIME(3) NOT NULL,
    `fine` DATETIME(3) NOT NULL,
    `clienteId` VARCHAR(191) NOT NULL,
    `coachId` VARCHAR(191) NULL,
    `pagato` BOOLEAN NOT NULL DEFAULT false,
    `prezzo` DOUBLE NULL,

    INDEX `Abbonamento_clienteId_fkey`(`clienteId`),
    INDEX `Abbonamento_coachId_fkey`(`coachId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AllenamentiEsercizio` (
    `id` VARCHAR(191) NOT NULL,
    `allenamentoId` VARCHAR(191) NOT NULL,
    `esercizioId` VARCHAR(191) NOT NULL,
    `serie` INTEGER NOT NULL,
    `ripetizioni` INTEGER NOT NULL,
    `peso` DOUBLE NULL,

    INDEX `AllenamentiEsercizio_esercizioId_fkey`(`esercizioId`),
    UNIQUE INDEX `AllenamentiEsercizio_allenamentoId_esercizioId_key`(`allenamentoId`, `esercizioId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Allenamento` (
    `id` VARCHAR(191) NOT NULL,
    `titolo` VARCHAR(191) NOT NULL,
    `descrizione` VARCHAR(191) NULL,
    `data` DATETIME(3) NOT NULL,
    `userId` VARCHAR(191) NULL,

    INDEX `Allenamento_userId_fkey`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cliente` (
    `id` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `note` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Cliente_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ClienteWorkout` (
    `id` VARCHAR(191) NOT NULL,
    `clienteId` VARCHAR(191) NOT NULL,
    `allenamentoId` VARCHAR(191) NOT NULL,

    INDEX `ClienteWorkout_allenamentoId_fkey`(`allenamentoId`),
    UNIQUE INDEX `ClienteWorkout_clienteId_allenamentoId_key`(`clienteId`, `allenamentoId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Esercizio` (
    `id` VARCHAR(191) NOT NULL,
    `nome` VARCHAR(191) NOT NULL,
    `descrizione` VARCHAR(191) NULL,
    `categoria` VARCHAR(191) NULL,
    `coachId` VARCHAR(191) NOT NULL,
    `immagineUrl` VARCHAR(191) NULL,

    INDEX `Esercizio_coachId_fkey`(`coachId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Feedback` (
    `id` VARCHAR(191) NOT NULL,
    `voto` INTEGER NOT NULL,
    `clienteId` VARCHAR(191) NOT NULL,
    `coachId` VARCHAR(191) NULL,
    `commento` VARCHAR(191) NULL,
    `creatoIl` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `allenamentoId` VARCHAR(191) NOT NULL,

    INDEX `Feedback_allenamentoId_fkey`(`allenamentoId`),
    INDEX `Feedback_clienteId_fkey`(`clienteId`),
    INDEX `Feedback_coachId_fkey`(`coachId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Messaggio` (
    `id` VARCHAR(191) NOT NULL,
    `daId` VARCHAR(191) NOT NULL,
    `aId` VARCHAR(191) NOT NULL,
    `clienteId` VARCHAR(191) NULL,
    `testo` VARCHAR(191) NOT NULL,
    `letto` BOOLEAN NOT NULL DEFAULT false,
    `inviatoIl` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Messaggio_aId_fkey`(`aId`),
    INDEX `Messaggio_clienteId_fkey`(`clienteId`),
    INDEX `Messaggio_daId_fkey`(`daId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Progresso` (
    `id` VARCHAR(191) NOT NULL,
    `data` DATETIME(3) NOT NULL,
    `altezza` DOUBLE NULL,
    `clienteId` VARCHAR(191) NOT NULL,
    `coachId` VARCHAR(191) NULL,
    `forza` VARCHAR(191) NULL,
    `note` VARCHAR(191) NULL,
    `peso` DOUBLE NULL,
    `torace` DOUBLE NULL,
    `vita` DOUBLE NULL,

    INDEX `Progresso_clienteId_fkey`(`clienteId`),
    INDEX `Progresso_coachId_fkey`(`coachId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Abbonamento` ADD CONSTRAINT `Abbonamento_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Abbonamento` ADD CONSTRAINT `Abbonamento_coachId_fkey` FOREIGN KEY (`coachId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AllenamentiEsercizio` ADD CONSTRAINT `AllenamentiEsercizio_allenamentoId_fkey` FOREIGN KEY (`allenamentoId`) REFERENCES `Allenamento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AllenamentiEsercizio` ADD CONSTRAINT `AllenamentiEsercizio_esercizioId_fkey` FOREIGN KEY (`esercizioId`) REFERENCES `Esercizio`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Allenamento` ADD CONSTRAINT `Allenamento_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cliente` ADD CONSTRAINT `Cliente_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ClienteWorkout` ADD CONSTRAINT `ClienteWorkout_allenamentoId_fkey` FOREIGN KEY (`allenamentoId`) REFERENCES `Allenamento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ClienteWorkout` ADD CONSTRAINT `ClienteWorkout_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Esercizio` ADD CONSTRAINT `Esercizio_coachId_fkey` FOREIGN KEY (`coachId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_allenamentoId_fkey` FOREIGN KEY (`allenamentoId`) REFERENCES `Allenamento`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_coachId_fkey` FOREIGN KEY (`coachId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Messaggio` ADD CONSTRAINT `Messaggio_aId_fkey` FOREIGN KEY (`aId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Messaggio` ADD CONSTRAINT `Messaggio_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Messaggio` ADD CONSTRAINT `Messaggio_daId_fkey` FOREIGN KEY (`daId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Progresso` ADD CONSTRAINT `Progresso_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Progresso` ADD CONSTRAINT `Progresso_coachId_fkey` FOREIGN KEY (`coachId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
