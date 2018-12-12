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
import {PostingTemplateQuestion} from "./postingTemplateQuestion";
import {QuestionType} from "./questionType";
import {UserPostingQuestionResponse} from "./UserPostingQuestionResponse";

@Entity("question",{schema:"dbo"})
export default class Question {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"questionID",
        })
    questionId: number;

    @ManyToOne((type)=>QuestionType, (QuestionType)=>QuestionType.questions,{  nullable:false })
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

    @Column("nvarchar",{
        nullable:false,
        length:120,
        default:"('')",
        name:"label",
        })
    label: string;

    @OneToMany((type)=>PostingTemplateQuestion, (PostingTemplateQuestion)=>PostingTemplateQuestion.question)
    postingTemplateQuestions: Promise<PostingTemplateQuestion[]>;

    @OneToOne((type)=>UserPostingQuestionResponse, (UserPostingQuestionResponse)=>UserPostingQuestionResponse.question2)
    userPostingQuestionResponse: Promise<UserPostingQuestionResponse | null>;

}
