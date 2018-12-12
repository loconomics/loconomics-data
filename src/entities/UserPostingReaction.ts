import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {UserPosting} from "./UserPosting";
import User from "./User"

@Entity("UserPostingReaction",{schema:"dbo"})
export class UserPostingReaction {

    @OneToOne((type)=>UserPosting, (UserPosting)=>UserPosting.userPostingReaction,{ primary:true, nullable:false })
    @JoinColumn({ name:"userPostingID"})
    userPosting: Promise<UserPosting | null>;

    @OneToOne((type)=>User, (User)=>User.userPostingReaction,{ primary:true, nullable:false })
    @JoinColumn({ name:"serviceProfessionalUserID"})
    serviceProfessionalUser: Promise<User | null>;

    @Column("int",{
        nullable:false,
        name:"reactionTypeID",
        })
    reactionTypeId: number;

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

    @Column("text",{
        nullable:true,
        name:"message",
        })
    message: string | null;

}
