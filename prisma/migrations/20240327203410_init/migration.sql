/*
  Warnings:

  - You are about to drop the `RolePermissions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SeasonStages` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `StageRequirements` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "RolePermissions" DROP CONSTRAINT "RolePermissions_permissionId_fkey";

-- DropForeignKey
ALTER TABLE "RolePermissions" DROP CONSTRAINT "RolePermissions_roleId_fkey";

-- DropForeignKey
ALTER TABLE "SeasonStages" DROP CONSTRAINT "SeasonStages_seasonId_fkey";

-- DropForeignKey
ALTER TABLE "SeasonStages" DROP CONSTRAINT "SeasonStages_stageId_fkey";

-- DropForeignKey
ALTER TABLE "StageRequirements" DROP CONSTRAINT "StageRequirements_requirementId_fkey";

-- DropForeignKey
ALTER TABLE "StageRequirements" DROP CONSTRAINT "StageRequirements_stageId_fkey";

-- DropTable
DROP TABLE "RolePermissions";

-- DropTable
DROP TABLE "SeasonStages";

-- DropTable
DROP TABLE "StageRequirements";

-- CreateTable
CREATE TABLE "_PermissionsToRoles" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_RequirementsToStages" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_SeasonsToStages" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_PermissionsToRoles_AB_unique" ON "_PermissionsToRoles"("A", "B");

-- CreateIndex
CREATE INDEX "_PermissionsToRoles_B_index" ON "_PermissionsToRoles"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_RequirementsToStages_AB_unique" ON "_RequirementsToStages"("A", "B");

-- CreateIndex
CREATE INDEX "_RequirementsToStages_B_index" ON "_RequirementsToStages"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_SeasonsToStages_AB_unique" ON "_SeasonsToStages"("A", "B");

-- CreateIndex
CREATE INDEX "_SeasonsToStages_B_index" ON "_SeasonsToStages"("B");

-- AddForeignKey
ALTER TABLE "_PermissionsToRoles" ADD CONSTRAINT "_PermissionsToRoles_A_fkey" FOREIGN KEY ("A") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionsToRoles" ADD CONSTRAINT "_PermissionsToRoles_B_fkey" FOREIGN KEY ("B") REFERENCES "Roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RequirementsToStages" ADD CONSTRAINT "_RequirementsToStages_A_fkey" FOREIGN KEY ("A") REFERENCES "Requirements"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RequirementsToStages" ADD CONSTRAINT "_RequirementsToStages_B_fkey" FOREIGN KEY ("B") REFERENCES "Stages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SeasonsToStages" ADD CONSTRAINT "_SeasonsToStages_A_fkey" FOREIGN KEY ("A") REFERENCES "Seasons"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SeasonsToStages" ADD CONSTRAINT "_SeasonsToStages_B_fkey" FOREIGN KEY ("B") REFERENCES "Stages"("id") ON DELETE CASCADE ON UPDATE CASCADE;
