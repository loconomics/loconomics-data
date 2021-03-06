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

@Entity("messagethreadstatus",{schema:"dbo"})
export class MessageThreadStatus {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"MessageThreadStatusID",
        })
    messageThreadStatusId: number;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"MessageThreadStatusName",
        })
    messageThreadStatusName: string;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"MessageThreadStatusDescription",
        })
    messageThreadStatusDescription: string | null;

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
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("varchar",{
        nullable:false,
        length:7,
        name:"MessageStatusColor",
        })
    messageStatusColor: string;

    @OneToMany((type) => MessagingThread, (MessagingThread) => MessagingThread.messageThreadStatus)
    messagingThreads: Promise<MessagingThread[]>;

}
