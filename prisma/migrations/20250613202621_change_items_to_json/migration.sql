/*
  Warnings:

  - You are about to alter the column `items` on the `Planner` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Json`.

*/
-- AlterTable
ALTER TABLE `Planner` MODIFY `items` JSON NOT NULL;
