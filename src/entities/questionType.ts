import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Question} from "./Question"
import {UserPostingQuestionResponse} from "./UserPostingQuestionResponse";

@Entity("questionType",{schema:"dbo"})
export class QuestionType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"questionTypeID",
        })
    questionTypeId: number;

    @Column("nvarchar",{
        nullable:false,
        length:50,
        name:"name",
        })
    name: string;

    @Column("nvarchar",{
        nullable:false,
        length:500,
        name:"description",
        })
    description: string;

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

    @OneToMany((type)=>Question, (Question)=>Question.questionType)
    questions: Promise<Question[]>;

    @OneToMany((type)=>UserPostingQuestionResponse, (UserPostingQuestionResponse)=>UserPostingQuestionResponse.questionType)
    userPostingQuestionResponses: Promise<UserPostingQuestionResponse[]>;

}
