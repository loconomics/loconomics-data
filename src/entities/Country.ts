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

@Entity("country",{schema:"dbo"})
export class Country {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"CountryID",
        })
    countryId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"CountryName",
        })
    countryName: string;

    @Column("varchar",{
        nullable:false,
        length:3,
        name:"CountryCode",
        })
    countryCode: string;

    @Column("char",{
        nullable:true,
        length:2,
        name:"CountryCodeAlpha2",
        })
    countryCodeAlpha2: string | null;

    @Column("varchar",{
        nullable:true,
        length:3,
        name:"CountryCallingCode",
        })
    countryCallingCode: string | null;

    @Column("datetime",{
        nullable:true,
        name:"CreatedDate",
        })
    createdDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("int",{
        nullable:true,
        name:"numcode",
        })
    numcode: number | null;

}
