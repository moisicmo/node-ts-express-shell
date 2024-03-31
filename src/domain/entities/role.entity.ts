import { PermissionEntity } from "..";

export class RoleEntity {
  constructor(
    public id: number,
    public name: string,
    public permissions?: PermissionEntity[],
  ) { }

  static fromObject(object: { [key: string]: any; }) {
    const { id, name, permissions } = object;
    return new RoleEntity(id, name, permissions.map((e:PermissionEntity)=>PermissionEntity.fromObject(e)));
  }
}
