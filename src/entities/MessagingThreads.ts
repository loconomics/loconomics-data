import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Messages} from "./Messages";
import {Messagethreadstatus} from "./messagethreadstatus";
import {Users} from "./users";

@Entity("MessagingThreads",{schema:"dbo"})
export class MessagingThreads {

    @PrimaryGeneratedColumn({
        name:"ThreadID",
        })
    threadId: number;

    @ManyToOne((type)=>Users, (Users)=>Users.messagingThreadss,{  nullable:false })
    @JoinColumn({ name:"CustomerUserID"})
    customerUser: Promise<Users | null>;

    @ManyToOne((type)=>Users, (Users)=>Users.messagingThreadss2,{  nullable:false })
    @JoinColumn({ name:"ProviderUserID"})
    providerUser: Promise<Users | null>;

    @Column("int",{
        nullable:true,
        name:"PositionID",
        })
    positionId: number | null;

    @ManyToOne((type)=>Messagethreadstatus, (Messagethreadstatus)=>Messagethreadstatus.messagingThreadss,{  nullable:false })
    @JoinColumn({ name:"MessageThreadStatusID"})
    messageThreadStatus: Promise<Messagethreadstatus | null>;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"Subject",
        })
    subject: string | null;

    @ManyToOne((type)=>Messages, (Messages)=>Messages.messagingThreadss,{  })
    @JoinColumn({ name:"LastMessageID"})
    lastMessage: Promise<Messages | null>;

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
        length:50,
        name:"ModifiedBy",
        })
    modifiedBy: string;

}
