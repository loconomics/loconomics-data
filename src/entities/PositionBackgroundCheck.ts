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

@Entity("positionbackgroundcheck",{schema:"dbo"})
export class PositionBackgroundCheck {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("varchar",{
        nullable:false,
        primary:true,
        length:25,
        name:"BackgroundCheckID",
        })
    backgroundCheckId: string;

    @Column("varchar",{
        nullable:false,
        primary:true,
        length:25,
        name:"StateProvinceID",
        })
    stateProvinceId: string;

    @Column("varchar",{
        nullable:false,
        primary:true,
        length:25,
        name:"CountryID",
        })
    countryId: string;

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

}
