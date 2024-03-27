/*
  Warnings:

  - A unique constraint covering the columns `[code]` on the table `Students` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `code` to the `Students` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Students" ADD COLUMN     "code" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Teachers" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "ci" TEXT NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Teachers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subjects" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "semester" INTEGER NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Subjects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Parallels" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "teacherId" INTEGER NOT NULL,
    "subjectId" INTEGER NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Parallels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Stages" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "start" DATE NOT NULL,
    "end" DATE NOT NULL,
    "weighing" INTEGER NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Stages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Requirements" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Requirements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StageRequirements" (
    "stageId" INTEGER NOT NULL,
    "requirementId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "TypeProjects" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TypeProjects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Categories" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Seasons" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "price" INTEGER NOT NULL,
    "start" DATE NOT NULL,
    "end" DATE NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Seasons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SeasonStages" (
    "stageId" INTEGER NOT NULL,
    "seasonId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Inscriptions" (
    "id" SERIAL NOT NULL,
    "studentId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "seasonId" INTEGER NOT NULL,
    "total" INTEGER NOT NULL,
    "amountDelivered" INTEGER NOT NULL,
    "returnedAmount" INTEGER NOT NULL,
    "url" VARCHAR(255) NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Inscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Projects" (
    "id" SERIAL NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "typeProjectId" INTEGER NOT NULL,
    "seasonId" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "code" TEXT NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectStudents" (
    "projectId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "ProjectHistories" (
    "parallelId" INTEGER NOT NULL,
    "projectId" INTEGER NOT NULL,
    "subjectId" INTEGER NOT NULL,
    "teacherId" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Teachers_userId_key" ON "Teachers"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Teachers_ci_key" ON "Teachers"("ci");

-- CreateIndex
CREATE UNIQUE INDEX "Parallels_teacherId_key" ON "Parallels"("teacherId");

-- CreateIndex
CREATE UNIQUE INDEX "Parallels_subjectId_key" ON "Parallels"("subjectId");

-- CreateIndex
CREATE UNIQUE INDEX "StageRequirements_stageId_key" ON "StageRequirements"("stageId");

-- CreateIndex
CREATE UNIQUE INDEX "StageRequirements_requirementId_key" ON "StageRequirements"("requirementId");

-- CreateIndex
CREATE UNIQUE INDEX "SeasonStages_stageId_key" ON "SeasonStages"("stageId");

-- CreateIndex
CREATE UNIQUE INDEX "SeasonStages_seasonId_key" ON "SeasonStages"("seasonId");

-- CreateIndex
CREATE UNIQUE INDEX "Inscriptions_studentId_key" ON "Inscriptions"("studentId");

-- CreateIndex
CREATE UNIQUE INDEX "Inscriptions_userId_key" ON "Inscriptions"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Inscriptions_seasonId_key" ON "Inscriptions"("seasonId");

-- CreateIndex
CREATE UNIQUE INDEX "Projects_categoryId_key" ON "Projects"("categoryId");

-- CreateIndex
CREATE UNIQUE INDEX "Projects_typeProjectId_key" ON "Projects"("typeProjectId");

-- CreateIndex
CREATE UNIQUE INDEX "Projects_seasonId_key" ON "Projects"("seasonId");

-- CreateIndex
CREATE UNIQUE INDEX "Projects_code_key" ON "Projects"("code");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectStudents_projectId_key" ON "ProjectStudents"("projectId");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectStudents_studentId_key" ON "ProjectStudents"("studentId");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectHistories_parallelId_key" ON "ProjectHistories"("parallelId");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectHistories_projectId_key" ON "ProjectHistories"("projectId");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectHistories_subjectId_key" ON "ProjectHistories"("subjectId");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectHistories_teacherId_key" ON "ProjectHistories"("teacherId");

-- CreateIndex
CREATE UNIQUE INDEX "Students_code_key" ON "Students"("code");

-- AddForeignKey
ALTER TABLE "Teachers" ADD CONSTRAINT "Teachers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Parallels" ADD CONSTRAINT "Parallels_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Parallels" ADD CONSTRAINT "Parallels_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "Subjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StageRequirements" ADD CONSTRAINT "StageRequirements_stageId_fkey" FOREIGN KEY ("stageId") REFERENCES "Stages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StageRequirements" ADD CONSTRAINT "StageRequirements_requirementId_fkey" FOREIGN KEY ("requirementId") REFERENCES "Requirements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SeasonStages" ADD CONSTRAINT "SeasonStages_stageId_fkey" FOREIGN KEY ("stageId") REFERENCES "Stages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SeasonStages" ADD CONSTRAINT "SeasonStages_seasonId_fkey" FOREIGN KEY ("seasonId") REFERENCES "Seasons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inscriptions" ADD CONSTRAINT "Inscriptions_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inscriptions" ADD CONSTRAINT "Inscriptions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inscriptions" ADD CONSTRAINT "Inscriptions_seasonId_fkey" FOREIGN KEY ("seasonId") REFERENCES "Seasons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Projects" ADD CONSTRAINT "Projects_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Projects" ADD CONSTRAINT "Projects_typeProjectId_fkey" FOREIGN KEY ("typeProjectId") REFERENCES "TypeProjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Projects" ADD CONSTRAINT "Projects_seasonId_fkey" FOREIGN KEY ("seasonId") REFERENCES "Seasons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectStudents" ADD CONSTRAINT "ProjectStudents_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectStudents" ADD CONSTRAINT "ProjectStudents_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectHistories" ADD CONSTRAINT "ProjectHistories_parallelId_fkey" FOREIGN KEY ("parallelId") REFERENCES "Parallels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectHistories" ADD CONSTRAINT "ProjectHistories_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectHistories" ADD CONSTRAINT "ProjectHistories_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "Subjects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectHistories" ADD CONSTRAINT "ProjectHistories_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "Teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
