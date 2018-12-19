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

import {Position} from "./Position"
import {Solution} from "./Solution";

@Entity("JobTitleSolution",{schema:"dbo"})
export class JobTitleSolution {

    @OneToOne((type) => Position, (Position) => Position.jobTitleSolution,{ primary:true, nullable:false })
    @JoinColumn({ name:"JobTitleID"})
    jobTitle: Promise<Position | null>;

    @OneToOne((type)=>Solution, (Solution)=>Solution.jobTitleSolution,{ primary:true, nullable:false })
    @JoinColumn({ name:"SolutionID"})
    solution: Promise<Solution | null>;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("bit",{
        nullable:true,
        name:"DefaultSelected",
        })
    defaultSelected: boolean | null;

    @Column("int",{
        nullable:true,
        name:"DisplayRank",
        })
    displayRank: number | null;

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

}
