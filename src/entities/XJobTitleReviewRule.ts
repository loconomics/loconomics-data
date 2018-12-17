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

@Entity("xJobTitleReviewRules",{schema:"dbo"})
export class XJobTitleReviewRule {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"JobTitleID",
        })
    jobTitleId: number;

    @Column("bit",{
        nullable:false,
        name:"SuppressReviewOfClient",
        })
    suppressReviewOfClient: boolean;

    @Column("bit",{
        nullable:false,
        name:"SuppressReviewOfServiceProfessional",
        })
    suppressReviewOfServiceProfessional: boolean;

    @Column("bit",{
        nullable:false,
        name:"RequestToReview",
        })
    requestToReview: boolean;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

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

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

}
