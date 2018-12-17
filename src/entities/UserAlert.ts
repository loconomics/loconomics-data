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

@Entity("UserAlert",{schema:"dbo"})
export class UserAlert {

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
        primary:true,
        name:"AlertID",
        })
    alertId: number;

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

    @Column("datetime",{
        nullable:true,
        name:"CompletedDate",
        })
    completedDate: Date | null;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"AlertQuery",
        })
    alertQuery: string | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"Dismissed",
        })
    dismissed: boolean;

}
