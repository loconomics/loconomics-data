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

import {AccountStatus} from "./AccountStatus"
import {Position} from "./Position"
import {User} from "./User"
import {UserListingSpecialization} from "./UserListingSpecialization"
import {UserSolution} from "./UserSolution"

@Entity("userprofilepositions",{schema:"dbo"})
@Index("IX_userprofilepositions",["user","position"],{unique:true})
export class UserProfilePosition {

    @PrimaryGeneratedColumn({
        name:"UserListingID",
        })
    userListingId: number;

    @OneToOne((type)=>User, (User)=>User.userprofilepositions,{  nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @OneToOne((type) => Position, (Position) => Position.userprofilepositions,{  nullable:false })
    @JoinColumn({ name:"PositionID"})
    position: Promise<Position | null>;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetime",{
        nullable:true,
        name:"CreateDate",
        })
    createDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:3,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @Column("varchar",{
        nullable:true,
        length:2000,
        name:"PositionIntro",
        })
    positionIntro: string | null;

    @ManyToOne((type) => AccountStatus, (AccountStatus) => AccountStatus.userprofilepositions, {  nullable:false })
    @JoinColumn({ name:"StatusID"})
    status: Promise<AccountStatus | null>;

    @Column("int",{
        nullable:true,
        name:"CancellationPolicyID",
        })
    cancellationPolicyId: number | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"InstantBooking",
        })
    instantBooking: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"bookMeButtonReady",
        })
    bookMeButtonReady: boolean;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"collectPaymentAtBookMeButton",
        })
    collectPaymentAtBookMeButton: boolean;

    @Column("nvarchar",{
        nullable:true,
        length:50,
        name:"Title",
        })
    title: string | null;

    @OneToOne((type)=>UserListingSpecialization, (UserListingSpecialization)=>UserListingSpecialization.userListing)
    userListingSpecialization: Promise<UserListingSpecialization | null>;

    @OneToMany((type)=>UserSolution, (UserSolution)=>UserSolution.userListing)
    userSolutions: Promise<UserSolution[]>;

}
