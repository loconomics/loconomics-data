import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("providertaxform",{schema:"dbo"})
export class Providertaxform {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ProviderUserID",
        })
    providerUserId: number;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"FullName",
        })
    fullName: string;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"BusinessName",
        })
    businessName: string | null;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"StreetApt",
        })
    streetApt: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"City",
        })
    city: string;

    @Column("int",{
        nullable:true,
        name:"PostalCodeID",
        })
    postalCodeId: number | null;

    @Column("int",{
        nullable:false,
        name:"StateProvinceID",
        })
    stateProvinceId: number;

    @Column("int",{
        nullable:false,
        name:"CountryID",
        })
    countryId: number;

    @Column("int",{
        nullable:false,
        name:"TaxEntityTypeID",
        })
    taxEntityTypeId: number;

    @Column("bit",{
        nullable:false,
        name:"ExemptPayee",
        })
    exemptPayee: boolean;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"TINTypeID",
        })
    tinTypeId: string;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"Signature",
        })
    signature: string;

    @Column("varchar",{
        nullable:false,
        length:500,
        name:"UserIPAddress",
        })
    userIpAddress: string;

    @Column("datetime",{
        nullable:false,
        name:"DateTimeSubmitted",
        })
    dateTimeSubmitted: Date;

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

    @Column("varchar",{
        nullable:true,
        length:64,
        name:"LastThreeTINDigits",
        })
    lastThreeTinDigits: string | null;

}
