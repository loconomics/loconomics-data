import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Solution} from "./Solution";
import {Users} from "./users";

@Entity("UserBadge",{schema:"dbo"})
export class UserBadge {

    @OneToOne((type)=>UserBadge, (UserBadge)=>UserBadge.userBadge2,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserBadgeID"})
    userBadge: Promise<UserBadge | null>;

    @ManyToOne((type)=>Users, (Users)=>Users.userBadges,{  nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<Users | null>;

    @ManyToOne((type)=>Solution, (Solution)=>Solution.userBadges,{  })
    @JoinColumn({ name:"SolutionID"})
    solution: Promise<Solution | null>;

    @Column("nvarchar",{
        nullable:false,
        length:255,
        name:"BadgeURL",
        })
    badgeUrl: string;

    @Column("nvarchar",{
        nullable:false,
        length:20,
        name:"Type",
        })
    type: string;

    @Column("nvarchar",{
        nullable:false,
        length:50,
        name:"Category",
        })
    category: string;

    @Column("datetimeoffset",{
        nullable:true,
        name:"ExpiryDate",
        })
    expiryDate: Date | null;

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
        name:"CreatedBy",
        })
    createdBy: string;

    @Column("nvarchar",{
        nullable:false,
        length:4,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @OneToOne((type)=>UserBadge, (UserBadge)=>UserBadge.userBadge)
    userBadge2: Promise<UserBadge | null>;

}
