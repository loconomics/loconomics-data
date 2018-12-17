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

import {Solution} from "./Solution";
import {UserListingSpecialization} from "./UserListingSpecialization";

@Entity("Specialization",{schema:"dbo"})
export class Specialization {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"SpecializationID",
        })
    specializationId: number;

    @ManyToOne((type)=>Solution, (Solution)=>Solution.specializations,{  nullable:false })
    @JoinColumn({ name:"SolutionID"})
    solution: Promise<Solution | null>;

    @Column("nvarchar",{
        nullable:false,
        length:100,
        name:"Name",
        })
    name: string;

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
        length:12,
        default:"('staff')",
        name:"CreatedBy",
        })
    createdBy: string;

    @Column("bit",{
        nullable:true,
        default:"((0))",
        name:"Approved",
        })
    approved: boolean | null;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @Column("int",{
        nullable:true,
        name:"EnteredByUserID",
        })
    enteredByUserId: number | null;

    @OneToOne((type)=>UserListingSpecialization, (UserListingSpecialization)=>UserListingSpecialization.specialization)
    userListingSpecialization: Promise<UserListingSpecialization | null>;

}
