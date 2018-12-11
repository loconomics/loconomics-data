import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Question} from "./question";
import {QuestionType} from "./questionType";
import {UserPosting} from "./UserPosting";

@Entity("UserPostingQuestionResponse",{schema:"dbo"})
export class UserPostingQuestionResponse {

    @OneToOne((type)=>UserPosting, (UserPosting)=>UserPosting.userPostingQuestionResponse,{ primary:true, nullable:false })
    @JoinColumn({ name:"userPostingID"})
    userPosting: Promise<UserPosting | null>;

    @OneToOne((type)=>Question, (Question)=>Question.userPostingQuestionResponse,{ primary:true, nullable:false })
    @JoinColumn({ name:"questionID"})
    question2: Promise<Question | null>;

    @ManyToOne((type)=>QuestionType, (QuestionType)=>QuestionType.userPostingQuestionResponses,{  nullable:false })
    @JoinColumn({ name:"questionTypeID"})
    questionType: Promise<QuestionType | null>;

    @Column("nvarchar",{
        nullable:false,
        length:120,
        name:"question",
        })
    question: string;

    @Column("nvarchar",{
        nullable:true,
        length:300,
        name:"helpBlock",
        })
    helpBlock: string | null;

    @Column("text",{
        nullable:false,
        name:"options",
        })
    options: string;

    @Column("text",{
        nullable:false,
        name:"responses",
        })
    responses: string;

    @Column("nvarchar",{
        nullable:false,
        length:60,
        name:"legend",
        })
    legend: string;

    @Column("text",{
        nullable:true,
        name:"branchLogic",
        })
    branchLogic: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:120,
        default:"('')",
        name:"label",
        })
    label: string;

}
