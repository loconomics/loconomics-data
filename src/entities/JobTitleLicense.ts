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

@Entity("jobTitleLicense",{schema:"dbo"})
export class JobTitleLicense {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"LicenseCertificationID",
        })
    licenseCertificationId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"StateProvinceID",
        })
    stateProvinceId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"CountryID",
        })
    countryId: number;

    @Column("bit",{
        nullable:false,
        name:"Required",
        })
    required: boolean;

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

    @Column("int",{
        nullable:false,
        primary:true,
        default:"((0))",
        name:"MunicipalityID",
        })
    municipalityId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        default:"((0))",
        name:"CountyID",
        })
    countyId: number;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"OptionGroup",
        })
    optionGroup: string | null;

}
