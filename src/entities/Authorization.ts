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

@Entity("authorizations",{schema:"dbo"})
@Index("IX_authorizations_token",["token"],{unique:true})
export class Authorization {

    @PrimaryGeneratedColumn({
        name:"id",
        })
    id: number;

    @Column("varchar",{
        nullable:false,
        length:216,
        name:"Token",
        })
    token: string;

    @Column("int",{
        nullable:false,
        name:"UserID",
        })
    userId: number;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"Scope",
        })
    scope: string;

    @Column("datetimeoffset",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetimeoffset",{
        nullable:true,
        name:"DeletedDate",
        })
    deletedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:64,
        name:"ClientAddress",
        })
    clientAddress: string | null;

    @Column("text",{
        nullable:true,
        name:"UserAgent",
        })
    userAgent: string | null;

}
