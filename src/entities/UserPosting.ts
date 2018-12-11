import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {UserPostingQuestionResponse} from "./UserPostingQuestionResponse";
import {UserPostingReaction} from "./UserPostingReaction";

@Entity("UserPosting",{schema:"dbo"})
export class UserPosting {

    @PrimaryGeneratedColumn({
        name:"userPostingID",
        })
    userPostingId: number;

    @Column("int",{
        nullable:false,
        name:"userID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        name:"solutionID",
        })
    solutionId: number;

    @Column("int",{
        nullable:true,
        name:"postingTemplateID",
        })
    postingTemplateId: number | null;

    @Column("nvarchar",{
        nullable:false,
        length:50,
        name:"title",
        })
    title: string;

    @Column("int",{
        nullable:false,
        name:"statusID",
        })
    statusId: number;

    @Column("varchar",{
        nullable:true,
        length:300,
        name:"neededSpecializationIDs",
        })
    neededSpecializationIDs: string | null;

    @Column("varchar",{
        nullable:true,
        length:300,
        name:"desiredSpecializationIDs",
        })
    desiredSpecializationIDs: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetimeoffset",{
        nullable:false,
        name:"createdDate",
        })
    createdDate: Date;

    @Column("datetimeoffset",{
        nullable:false,
        name:"updatedDate",
        })
    updatedDate: Date;

    @Column("nvarchar",{
        nullable:false,
        length:10,
        name:"modifiedBy",
        })
    modifiedBy: string;

    @OneToOne((type)=>UserPostingQuestionResponse, (UserPostingQuestionResponse)=>UserPostingQuestionResponse.userPosting)
    userPostingQuestionResponse: Promise<UserPostingQuestionResponse | null>;

    @OneToOne((type)=>UserPostingReaction, (UserPostingReaction)=>UserPostingReaction.userPosting)
    userPostingReaction: Promise<UserPostingReaction | null>;

}
