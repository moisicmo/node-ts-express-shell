/*
  Warnings:

  - You are about to drop the `ProjectStudents` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "ProjectStudents" DROP CONSTRAINT "ProjectStudents_projectId_fkey";

-- DropForeignKey
ALTER TABLE "ProjectStudents" DROP CONSTRAINT "ProjectStudents_studentId_fkey";

-- DropTable
DROP TABLE "ProjectStudents";

-- CreateTable
CREATE TABLE "_ProjectsToStudents" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ProjectsToStudents_AB_unique" ON "_ProjectsToStudents"("A", "B");

-- CreateIndex
CREATE INDEX "_ProjectsToStudents_B_index" ON "_ProjectsToStudents"("B");

-- AddForeignKey
ALTER TABLE "_ProjectsToStudents" ADD CONSTRAINT "_ProjectsToStudents_A_fkey" FOREIGN KEY ("A") REFERENCES "Projects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProjectsToStudents" ADD CONSTRAINT "_ProjectsToStudents_B_fkey" FOREIGN KEY ("B") REFERENCES "Students"("id") ON DELETE CASCADE ON UPDATE CASCADE;
