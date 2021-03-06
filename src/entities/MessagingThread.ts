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

import {Message} from "./Message"
import {MessageThreadStatus} from "./MessageThreadStatus"
import {User} from "./User"

@Entity("MessagingThreads",{schema:"dbo"})
export class MessagingThread {

    @PrimaryGeneratedColumn({
        name:"ThreadID",
        })
    threadId: number;

    @ManyToOne((type) => User, (User) => User.customerMessages,{  nullable:false })
    @JoinColumn({ name:"CustomerUserID"})
    customerUser: Promise<User | null>;

    @ManyToOne((type) => User, (User) => User.providerMessages,{  nullable:false })
    @JoinColumn({ name:"ProviderUserID"})
    providerUser: Promise<User | null>;

    @Column("int",{
        nullable:true,
        name:"PositionID",
        })
    positionId: number | null;

    @ManyToOne(
        (type) => MessageThreadStatus,
        (MessageThreadStatus) => MessageThreadStatus.messagingThreads,
        {  nullable:false },
    )
    @JoinColumn({ name:"MessageThreadStatusID"})
    messageThreadStatus: Promise<MessageThreadStatus | null>;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"Subject",
        })
    subject: string | null;

    @ManyToOne(
        (type) => Message, 
        (Message) => Message.lastMessages,
        {  }
    )
    @JoinColumn({ name:"LastMessageID"})
    lastMessage: Promise<Message | null>;

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
