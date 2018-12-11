import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("positionratings",{schema:"dbo"})
export class Positionratings {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"Rating1",
        })
    rating1: string;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"Rating2",
        })
    rating2: string;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"Rating3",
        })
    rating3: string;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"Rating4",
        })
    rating4: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating1FormDescription",
        })
    rating1FormDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating2FormDescription",
        })
    rating2FormDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating3FormDescription",
        })
    rating3FormDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating4FormDescription",
        })
    rating4FormDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating1ProfileDescription",
        })
    rating1ProfileDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating2ProfileDescription",
        })
    rating2ProfileDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating3ProfileDescription",
        })
    rating3ProfileDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"Rating4ProfileDescription",
        })
    rating4ProfileDescription: string | null;

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
