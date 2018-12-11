import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("servicecategoryposition",{schema:"dbo"})
export class Servicecategoryposition {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceCategoryID",
        })
    serviceCategoryId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("int",{
        nullable:false,
        default:"((1))",
        name:"Rank",
        })
    rank: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetime",{
        nullable:false,
        name:"CreateDate",
        })
    createDate: Date;

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

    @Column("int",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: number;

}
