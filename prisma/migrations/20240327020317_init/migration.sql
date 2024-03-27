/*
  Warnings:

  - The primary key for the `RolePermission` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `RolePermission` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "RolePermission" DROP CONSTRAINT "RolePermission_pkey",
DROP COLUMN "id";
