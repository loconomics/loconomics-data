import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {UserPosting} from "./UserPosting";
import {Users} from "./users";

@Entity("UserPostingReaction",{schema:"dbo"})
export class UserPostingReaction {

    @OneToOne((type)=>UserPosting, (UserPosting)=>UserPosting.userPostingReaction,{ primary:true, nullable:false })
    @JoinColumn({ name:"userPostingID"})
    userPosting: Promise<UserPosting | null>;

    @OneToOne((type)=>Users, (Users)=>Users.userPostingReaction,{ primary:true, nullable:false })
    @JoinColumn({ name:"serviceProfessionalUserID"})
    serviceProfessionalUser: Promise<Users | null>;

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
