import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {JobTitleSolution} from "./JobTitleSolution";
import {SearchSubCategorySolution} from "./SearchSubCategorySolution";
import Specialization from "./Specialization"
import {UserBadge} from "./UserBadge";
import {UserSolution} from "./UserSolution";

@Entity("Solution",{schema:"dbo"})
export class Solution {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"SolutionID",
        })
    solutionId: number;

    @Column("nvarchar",{
        nullable:false,
        length:100,
        name:"Name",
        })
    name: string;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"CredentialCheckRequired",
        })
    credentialCheckRequired: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"BackgroundCheckRequired",
        })
    backgroundCheckRequired: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsHIPAA",
        })
    isHipaa: boolean;

    @Column("int",{
        nullable:true,
        name:"TaxActivityID",
        })
    taxActivityId: number | null;

    @Column("int",{
        nullable:true,
        name:"PostingTemplateID",
        })
    postingTemplateId: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:255,
        name:"Image",
        })
    image: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetimeoffset",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetimeoffset",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("nvarchar",{
        nullable:false,
        length:4,
        default:"('sys')",
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @OneToOne((type)=>JobTitleSolution, (JobTitleSolution)=>JobTitleSolution.solution)
    jobTitleSolution: Promise<JobTitleSolution | null>;

    @OneToOne((type)=>SearchSubCategorySolution, (SearchSubCategorySolution)=>SearchSubCategorySolution.solution)
    searchSubCategorySolution: Promise<SearchSubCategorySolution | null>;

    @OneToMany((type)=>Specialization, (Specialization)=>Specialization.solution)
    specializations: Promise<Specialization[]>;

    @OneToMany((type)=>UserBadge, (UserBadge)=>UserBadge.solution)
    userBadges: Promise<UserBadge[]>;

    @OneToMany((type)=>UserSolution, (UserSolution)=>UserSolution.solution)
    userSolutions: Promise<UserSolution[]>;

}
