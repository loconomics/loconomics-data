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

@Entity("address",{schema:"dbo"})
export class Address {

    @PrimaryGeneratedColumn({
        name:"AddressID",
        })
    addressId: number;

    @Column("int",{
        nullable:false,
        name:"UserID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        name:"AddressTypeID",
        })
    addressTypeId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"AddressName",
        })
    addressName: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"AddressLine1",
        })
    addressLine1: string;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"AddressLine2",
        })
    addressLine2: string | null;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"City",
        })
    city: string;

    @Column("int",{
        nullable:false,
        name:"StateProvinceID",
        })
    stateProvinceId: number;

    @Column("int",{
        nullable:false,
        name:"PostalCodeID",
        })
    postalCodeId: number;

    @Column("int",{
        nullable:false,
        name:"CountryID",
        })
    countryId: number;

    @Column("float",{
        nullable:true,
        precision:53,
        name:"Latitude",
        })
    latitude: number | null;

    @Column("float",{
        nullable:true,
        precision:53,
        name:"Longitude",
        })
    longitude: number | null;

    @Column("varchar",{
        nullable:true,
        length:2073,
        name:"GoogleMapsURL",
        })
    googleMapsUrl: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"SpecialInstructions",
        })
    specialInstructions: string | null;

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
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @Column("int",{
        nullable:false,
        name:"CreatedBy",
        })
    createdBy: number;

}
