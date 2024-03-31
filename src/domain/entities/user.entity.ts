import { StaffEntity } from '..';
import { CustomError } from '../errors/custom.error';

export class UserEntity {

  constructor(
    public id: number,
    public name: string,
    public email: string,
    public emailValidated: boolean,
    public password: string,
    public staffs?: StaffEntity,
    public image?: string,
  ) { }

  static fromObject(object: { [key: string]: any; }) {
    const { id, name, email, emailValidated, password, staffs, image } = object;

    if (!id) throw CustomError.badRequest('Falta id');
    if (!name) throw CustomError.badRequest('Falta el nombre');
    if (!email) throw CustomError.badRequest('Falta el correo');
    if (!emailValidated) throw CustomError.badRequest('Falta la validación del correo');
    if (!password) throw CustomError.badRequest('Falta la contraseña');
    
    const staffsEntity = staffs ? StaffEntity.fromObject(staffs) : undefined;

    return new UserEntity(id, name, email, emailValidated, password, staffsEntity, image);
  }
}
