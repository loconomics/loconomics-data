import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Solution} from "./Solution";
import {Userprofilepositions} from "./userprofilepositions";
import {User} from "./User"

@Entity("UserSolution",{schema:"dbo"})
export class UserSolution {

    @PrimaryGeneratedColumn({
        name:"UserSolutionID",
        })
    userSolutionId: number;

    @ManyToOne((type)=>User, (User)=>User.userSolutions,{  nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @ManyToOne((type)=>Userprofilepositions, (Userprofilepositions)=>Userprofilepositions.userSolutions,{  nullable:false })
    @JoinColumn({ name:"UserListingID"})
    userListing: Promise<Userprofilepositions | null>;

    @ManyToOne((type)=>Solution, (Solution)=>Solution.userSolutions,{  nullable:false })
    @JoinColumn({ name:"SolutionID"})
    solution: Promise<Solution | null>;

    @Column("int",{
        nullable:true,
        name:"DisplayRank",
        })
    displayRank: number | null;

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

}
