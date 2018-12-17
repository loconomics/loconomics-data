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

import {Specialization} from "./Specialization"
import {User} from "./User"
import {UserProfilePosition} from "./UserProfilePosition"

@Entity("UserListingSpecialization",{schema:"dbo"})
export class UserListingSpecialization {

    @OneToOne((type)=>User, (User)=>User.userListingSpecialization,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @OneToOne(
        (type) => UserProfilePosition,
        (UserProfilePosition) => UserProfilePosition.userListingSpecialization,
        { primary:true, nullable:false },
    )
    @JoinColumn({ name:"UserListingID"})
    userListing: Promise<UserProfilePosition | null>;

    @OneToOne(
        (type) => Specialization,
        (Specialization) =>Specialization.userListingSpecialization,
        { primary:true, nullable:false },
    )
    @JoinColumn({ name:"SpecializationID"})
    specialization: Promise<Specialization | null>;

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
