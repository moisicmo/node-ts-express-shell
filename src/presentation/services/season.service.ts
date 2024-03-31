import { PrismaClient } from '@prisma/client';
import { CustomError, PaginationDto, UserEntity, SeasonEntity, SeasonDto } from '../../domain';

const prisma = new PrismaClient();

export class SeasonService {

  constructor() { }

  async getSeasons(paginationDto: PaginationDto) {
    const { page, limit } = paginationDto;
    try {

      const [total, seasons] = await Promise.all([
        prisma.seasons.count({ where: { state: true } }),
        prisma.seasons.findMany({
          skip: (page - 1) * limit,
          take: limit,
          where:{
            state:true
          },
          include: {
            stages: true
          }
        }),
      ]);

      return {
        page: page,
        limit: limit,
        total: total,
        next: `/api/season?page=${(page + 1)}&limit=${limit}`,
        prev: (page - 1 > 0) ? `/api/season?page=${(page - 1)}&limit=${limit}` : null,
        seasons: seasons.map(season => {
          const { ...seasonEntity } = SeasonEntity.fromObject(season);
          return seasonEntity;
        })
      };
    } catch (error) {
      throw CustomError.internalServer('Internal Server Error');
    }
  }

  async createSeason(seasonDto: SeasonDto, user: UserEntity) {
    const { stages, ...createSeasonDto } = seasonDto;
    const seasonExists = await prisma.seasons.findFirst({ where: { name: createSeasonDto.name } });
    if (seasonExists) throw CustomError.badRequest('la temporada ya existe');

    try {
      const season = await prisma.seasons.create({
        data: {
          ...createSeasonDto
        },
      });
      if (stages && stages.length > 0) {
        await prisma.seasons.update({
          where: { id: season.id },
          data: {
            stages: {
              connect: stages.map(stageId => ({ id: stageId })),
            },
          },
        });
      }
      const seasonCreate = await prisma.seasons.findFirst({
        where: {
          id: season.id
        },
        include: {
          stages: true
        }
      });

      const { ...seasonEntity } = SeasonEntity.fromObject(seasonCreate!);
      return seasonEntity;

    } catch (error) {
      throw CustomError.internalServer(`${error}`);
    }
  }

  async updateSeason(seasonDto: SeasonDto, user: UserEntity, seasonId: number) {
    const { stages, ...updateSeasonDto } = seasonDto;
    const existingSeasonWithName = await prisma.seasons.findFirst({
      where: {
        AND: [
          { name: updateSeasonDto.name },
          { NOT: { id: seasonId } },
        ],
      },
    });
    if (existingSeasonWithName) throw CustomError.badRequest('Ya existe una temporada con el mismo nombre');
    const seasonExists = await prisma.seasons.findFirst({
      where: { id: seasonId },
      include: {
        stages: true
      }
    });
    if (!seasonExists) throw CustomError.badRequest('La temporada no existe');

    try {
      const season = await prisma.seasons.update({
        where: { id: seasonId },
        data: {
          ...updateSeasonDto,
          stages: {
            disconnect: seasonExists.stages.map(stage => ({ id: stage.id })),
            connect: stages.map(stageId => ({ id: stageId }))
          },
        },
        include: {
          stages: true
        }
      });
      return SeasonEntity.fromObject(season);
    } catch (error) {
      throw CustomError.internalServer(`${error}`);
    }
  }

  async deleteSeason(user: UserEntity, seasonId: number) {
    const seasonExists = await prisma.seasons.findFirst({
      where: { id: seasonId },
      include: {
        stages: true
      }
    });
    if (!seasonExists) throw CustomError.badRequest('La temporada no existe');
    try {
      await prisma.seasons.update({
        where: { id: seasonId },
        data: {
          state: false,
          stages: {
            disconnect: seasonExists.stages.map(stage => ({ id: stage.id })),
          },
        },
        include: {
          stages: true
        }
      });

      return { msg: 'Temporada eliminado' };
    } catch (error) {
      throw CustomError.internalServer(`${error}`);
    }
  }
}


