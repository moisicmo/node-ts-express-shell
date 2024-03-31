import { PrismaClient } from '@prisma/client';
import { bcryptAdapter } from '../src/config';


async function main() {
  const prisma = new PrismaClient();

  try {

    const user = await prisma.users.upsert({
      where: { email: 'moisic.mo@gmail.com' },
      update: {},
      create: {
        name: 'Moises',
        lastName: 'Ochoa',
        email: 'moisic.mo@gmail.com',
        phone: '59173735766',
        password: bcryptAdapter.hash('8312915'),
      },
    });

    const role = await prisma.roles.upsert({
      where: { id: 1 },
      update: {},
      create: {
        name: 'administrador',
        permissions: {
          create: [
            {
              name: 'crear',
              module: 'crear'
            },
            {
              name: 'editar',
              module: 'editar'
            }
          ]
        }
      }
    });

    const staff = await prisma.staffs.upsert({
      where: { userId: user.id, roleId: role.id },
      update: {},
      create: {
        userId: user.id,
        roleId: role.id,
        superStaff: true
      },
    });

    console.log('Datos de semilla insertados correctamente.');
  } catch (error) {
    console.error('Error al insertar datos de semilla:', error);
  } finally {
    await prisma.$disconnect();
  }
}

main();
