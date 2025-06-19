-- DropForeignKey
ALTER TABLE `Ticket` DROP FOREIGN KEY `Ticket_showId_fkey`;

-- DropIndex
DROP INDEX `Ticket_showId_idx` ON `Ticket`;

-- AlterTable
ALTER TABLE `Ticket` MODIFY `showId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_showId_fkey` FOREIGN KEY (`showId`) REFERENCES `Show`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
