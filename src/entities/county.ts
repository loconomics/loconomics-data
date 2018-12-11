import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Municipality} from "./municipality";
import {Postalcode} from "./postalcode";
import {Stateprovince} from "./stateprovince";

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

    @ManyToOne((type)=>Stateprovince, (Stateprovince)=>Stateprovince.countys,{  nullable:false })
    @JoinColumn({ name:"StateProvinceID"})
    stateProvince: Promise<Stateprovince | null>;

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

    @OneToMany((type)=>Postalcode, (Postalcode)=>Postalcode.county)
    postalcodes: Promise<Postalcode[]>;

}