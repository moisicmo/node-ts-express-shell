import { RoleEntity } from "..";

export class StaffEntity {
  constructor(
    public id: number,
    public role?: RoleEntity,
  ) { }

  static fromObject(object: { [key: string]: any; }) {
    const { id, role } = object;
    return new StaffEntity(id, RoleEntity.fromObject(role));
  }
}