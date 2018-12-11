import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("servicecategorypositionattribute",{schema:"dbo"})
export class Servicecategorypositionattribute {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceAttributeCategoryID",
        })
    serviceAttributeCategoryId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceAttributeID",
        })
    serviceAttributeId: number;

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
        length:20,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @Column("int",{
        nullable:true,
        name:"EnteredByUserID",
        })
    enteredByUserId: number | null;

    @Column("bit",{
        nullable:true,
        name:"Approved",
        })
    approved: boolean | null;

}
