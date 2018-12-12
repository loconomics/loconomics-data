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

@Entity("postingTemplate",{schema:"dbo"})
export default class PostingTemplate {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"postingTemplateID",
        })
    postingTemplateId: number;

    @Column("nvarchar",{
        nullable:false,
        length:200,
        name:"name",
        })
    name: string;

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

    @Column("nchar",{
        nullable:false,
        length:5,
        name:"modifiedBy",
        })
    modifiedBy: string;

    @OneToMany((type)=>PostingTemplateQuestion, (PostingTemplateQuestion)=>PostingTemplateQuestion.postingTemplate)
    postingTemplateQuestions: Promise<PostingTemplateQuestion[]>;

}
