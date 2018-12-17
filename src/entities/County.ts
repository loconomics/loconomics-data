import {
    Column,
    Entity,
    Index,
    JoinColumn,
    JoinTable,
    ManyToMany,
    ManyToOne,
    OneToMany,
    OneToOne,
    PrimaryColumn,
    PrimaryGeneratedColumn,
    RelationId,
} from "typeorm";

import {Municipality} from "./Municipality"
import {PostalCode} from "./PostalCode"
import {StateProvince} from "./StateProvince"

@Entity("county",{schema:"dbo"})
export class County {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"CountyID",
        })
    countyId: number;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"CountyName",
        })
    countyName: string | null;

    @Column("int",{
        nullable:true,
        name:"FIPSCode",
        })
    fipsCode: number | null;

    @ManyToOne((type)=>StateProvince, (StateProvince)=>StateProvince.countys,{  nullable:false })
    @JoinColumn({ name:"StateProvinceID"})
    stateProvince: Promise<StateProvince | null>;

    @Column("datetime",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @OneToMany((type)=>Municipality, (Municipality)=>Municipality.county)
    municipalitys: Promise<Municipality[]>;

    @OneToMany((type)=>PostalCode, (PostalCode)=>PostalCode.county)
    postalcodes: Promise<PostalCode[]>;

}
