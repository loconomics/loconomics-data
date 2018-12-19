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

import {MessagingThread} from "./MessagingThread"

@Entity("Messages",{schema:"dbo"})
@Index("idx_Messages",["messageTypeId"])
export class Messages {

    @PrimaryGeneratedColumn({
        name:"MessageID",
        })
    messageId: number;

    @Column("int",{
        nullable:false,
        name:"ThreadID",
        })
    threadId: number;

    @Column("int",{
        nullable:false,
        name:"MessageTypeID",
        })
    messageTypeId: number;

    @Column("int",{
        nullable:true,
        name:"AuxID",
        })
    auxId: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:50,
        name:"AuxT",
        })
    auxT: string | null;

    @Column("varchar",{
        nullable:false,
        length:4000,
        name:"BodyText",
        })
    bodyText: string;

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

    @Column("int",{
        nullable:false,
        default:"((0))",
        name:"SentByUserId",
        })
    sentByUserId: number;

    @OneToMany((type) => MessagingThread, (MessagingThread) => MessagingThread.lastMessage)
    lastMessages: Promise<MessagingThread[]>;

}
