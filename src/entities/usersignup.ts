import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("usersignup",{schema:"dbo"})
@Index("UQ__usersign__A9D10534C226C65B",["email"],{unique:true})
export class Usersignup {

    @PrimaryGeneratedColumn({
        name:"UserId",
        })
    userId: number;

    @Column("nvarchar",{
        nullable:false,
        unique: true,
        length:56,
        name:"Email",
        })
    email: string;

}
