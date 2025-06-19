-- CreateTable
CREATE TABLE `Planner` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `date` VARCHAR(191) NOT NULL,
    `items` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Planner` ADD CONSTRAINT `Planner_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- RenameIndex
ALTER TABLE `Abbonamento` RENAME INDEX `Abbonamento_clienteId_fkey` TO `Abbonamento_clienteId_idx`;

-- RenameIndex
ALTER TABLE `Abbonamento` RENAME INDEX `Abbonamento_coachId_fkey` TO `Abbonamento_coachId_idx`;

-- RenameIndex
ALTER TABLE `AllenamentiEsercizio` RENAME INDEX `AllenamentiEsercizio_esercizioId_fkey` TO `AllenamentiEsercizio_esercizioId_idx`;

-- RenameIndex
ALTER TABLE `Allenamento` RENAME INDEX `Allenamento_userId_fkey` TO `Allenamento_userId_idx`;

-- RenameIndex
ALTER TABLE `ClienteWorkout` RENAME INDEX `ClienteWorkout_allenamentoId_fkey` TO `ClienteWorkout_allenamentoId_idx`;

-- RenameIndex
ALTER TABLE `Esercizio` RENAME INDEX `Esercizio_coachId_fkey` TO `Esercizio_coachId_idx`;

-- RenameIndex
ALTER TABLE `Feedback` RENAME INDEX `Feedback_allenamentoId_fkey` TO `Feedback_allenamentoId_idx`;

-- RenameIndex
ALTER TABLE `Feedback` RENAME INDEX `Feedback_clienteId_fkey` TO `Feedback_clienteId_idx`;

-- RenameIndex
ALTER TABLE `Feedback` RENAME INDEX `Feedback_coachId_fkey` TO `Feedback_coachId_idx`;

-- RenameIndex
ALTER TABLE `Messaggio` RENAME INDEX `Messaggio_aId_fkey` TO `Messaggio_aId_idx`;

-- RenameIndex
ALTER TABLE `Messaggio` RENAME INDEX `Messaggio_clienteId_fkey` TO `Messaggio_clienteId_idx`;

-- RenameIndex
ALTER TABLE `Messaggio` RENAME INDEX `Messaggio_daId_fkey` TO `Messaggio_daId_idx`;

-- RenameIndex
ALTER TABLE `Progresso` RENAME INDEX `Progresso_clienteId_fkey` TO `Progresso_clienteId_idx`;

-- RenameIndex
ALTER TABLE `Progresso` RENAME INDEX `Progresso_coachId_fkey` TO `Progresso_coachId_idx`;
