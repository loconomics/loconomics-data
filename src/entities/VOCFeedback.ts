import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("VOCFeedback",{schema:"dbo"})
export class VocFeedback {

    @PrimaryGeneratedColumn({
        name:"VOCFeedbackID",
        })
    vocFeedbackId: number;

    @Column("int",{
        nullable:false,
        name:"VOCElementID",
        })
    vocElementId: number;

    @Column("int",{
        nullable:false,
        name:"VOCExperienceCategoryID",
        })
    vocExperienceCategoryId: number;

    @Column("int",{
        nullable:false,
        name:"UserID",
        })
    userId: number;

    @Column("text",{
        nullable:false,
        name:"Feedback",
        })
    feedback: string;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"VOCFlag1",
        })
    vocFlag1: string | null;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"VOCFlag2",
        })
    vocFlag2: string | null;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"VOCFlag3",
        })
    vocFlag3: string | null;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"VOCFlag4",
        })
    vocFlag4: string | null;

    @Column("text",{
        nullable:true,
        name:"UserDevice",
        })
    userDevice: string | null;

    @Column("int",{
        nullable:true,
        name:"ZenDeskTicketNumber",
        })
    zenDeskTicketNumber: number | null;

    @Column("int",{
        nullable:true,
        name:"ProviderUserID",
        })
    providerUserId: number | null;

    @Column("int",{
        nullable:true,
        name:"ProviderPositionID",
        })
    providerPositionId: number | null;

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
        length:3,
        name:"ModifiedBy",
        })
    modifiedBy: string;

}
