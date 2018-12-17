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

@Entity("ServiceAttributeExperienceLevel",{schema:"dbo"})
export class ServiceAttributeExperienceLevel {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("int",{
        nullable:false,
        name:"ExperienceLevelID",
        })
    experienceLevelId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

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

}
