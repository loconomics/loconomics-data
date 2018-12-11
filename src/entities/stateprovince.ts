import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {County} from "./county";
import {Institution} from "./institution";
import {Postalcode} from "./postalcode";

@Entity("stateprovince",{schema:"dbo"})
export class Stateprovince {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"StateProvinceID",
        })
    stateProvinceId: number;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"StateProvinceName",
        })
    stateProvinceName: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"StateProvinceCode",
        })
    stateProvinceCode: string | null;

    @Column("int",{
        nullable:false,
        name:"CountryID",
        })
    countryId: number;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"RegionCode",
        })
    regionCode: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"PostalCodePrefix",
        })
    postalCodePrefix: string | null;

    @OneToMany((type)=>County, (County)=>County.stateProvince)
    countys: Promise<County[]>;

    @OneToMany((type)=>Institution, (Institution)=>Institution.stateProvince)
    institutions: Promise<Institution[]>;

    @OneToMany((type)=>Postalcode, (Postalcode)=>Postalcode.stateProvince)
    postalcodes: Promise<Postalcode[]>;

}