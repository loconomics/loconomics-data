import {Expose} from "class-transformer"
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

import {County} from "./County"
import {Institution} from "./Institution"
import {PostalCode} from "./PostalCode"

@Entity("stateprovince",{schema:"dbo"})
export class StateProvince {

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
    @Expose({name: "name"})
    stateProvinceName: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"StateProvinceCode",
        })
    @Expose({name: "code"})
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

    @OneToMany((type)=>PostalCode, (PostalCode)=>PostalCode.stateProvince)
    postalcodes: Promise<PostalCode[]>;

}
