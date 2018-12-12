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
import {County} from "./county";
import {Municipality} from "./municipality";
import {Stateprovince} from "./stateprovince";

@Entity("postalcode",{schema:"dbo"})
export default class PostalCode {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PostalCodeID",
        })
    postalCodeId: number;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"PostalCode",
        })
    postalCode: string | null;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"City",
        })
    city: string | null;

    @ManyToOne((type)=>Stateprovince, (Stateprovince)=>Stateprovince.postalcodes,{  nullable:false })
    @JoinColumn({ name:"StateProvinceID"})
    stateProvince: Promise<Stateprovince | null>;

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

    @Column("decimal",{
        nullable:true,
        precision:18,
        scale:0,
        name:"StandardOffset",
        })
    standardOffset: number | null;

    @Column("bit",{
        nullable:true,
        name:"DST",
        })
    dst: boolean | null;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"Location",
        })
    location: string | null;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"PostalCodeType",
        })
    postalCodeType: string | null;

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

    @ManyToOne((type)=>Municipality, (Municipality)=>Municipality.postalcodes,{  nullable:false })
    @JoinColumn({ name:"MunicipalityID"})
    municipality: Promise<Municipality | null>;

    @ManyToOne((type)=>County, (County)=>County.postalcodes,{  nullable:false })
    @JoinColumn({ name:"CountyID"})
    county: Promise<County | null>;

}
