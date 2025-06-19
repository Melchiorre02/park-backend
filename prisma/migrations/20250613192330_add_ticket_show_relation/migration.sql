/*
  Warnings:

  - You are about to drop the column `createdAt` on the `Ticket` table. All the data in the column will be lost.
  - Added the required column `code` to the `Ticket` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Ticket` DROP COLUMN `createdAt`,
    ADD COLUMN `code` VARCHAR(191) NOT NULL,
    ADD COLUMN `type` VARCHAR(191) NOT NULL;
