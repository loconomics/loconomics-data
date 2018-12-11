import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("VOCElement",{schema:"dbo"})
export class VocElement {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VOCElementID",
        })
    vocElementId: number;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"VOCElementName",
        })
    vocElementName: string | null;

    @Column("int",{
        nullable:true,
        name:"ScoreStartValue",
        })
    scoreStartValue: number | null;

    @Column("int",{
        nullable:true,
        name:"ScoreMidValue",
        })
    scoreMidValue: number | null;

    @Column("int",{
        nullable:true,
        name:"ScoreEndValue",
        })
    scoreEndValue: number | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"ScoreStartLabel",
        })
    scoreStartLabel: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"ScoreMidLabel",
        })
    scoreMidLabel: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"ScoreEndLabel",
        })
    scoreEndLabel: string | null;

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
        length:3,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

}
