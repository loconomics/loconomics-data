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

import {PostingTemplate} from "./PostingTemplate"
import {Question} from "./Question"

@Entity("postingTemplateQuestion",{schema:"dbo"})
export class PostingTemplateQuestion {

    @PrimaryGeneratedColumn({
        name:"postingTemplateQuestionID",
        })
    postingTemplateQuestionId: number;

    @ManyToOne((type)=>PostingTemplate, (PostingTemplate)=>PostingTemplate.postingTemplateQuestions,{  nullable:false })
    @JoinColumn({ name:"postingTemplateID"})
    postingTemplate: Promise<PostingTemplate | null>;

    @ManyToOne((type)=>Question, (Question)=>Question.postingTemplateQuestions,{  nullable:false })
    @JoinColumn({ name:"questionID"})
    question: Promise<Question | null>;

    @Column("nvarchar",{
        nullable:false,
        length:150,
        name:"legend",
        })
    legend: string;

    @Column("text",{
        nullable:true,
        name:"branchLogic",
        })
    branchLogic: string | null;

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

    @Column("nchar",{
        nullable:false,
        length:5,
        name:"modifiedby",
        })
    modifiedby: string;

    @Column("tinyint",{
        nullable:false,
        name:"active",
        })
    active: number;

}
