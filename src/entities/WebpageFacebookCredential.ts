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

@Entity("webpages_FacebookCredentials",{schema:"dbo"})
export class WebpageFacebookCredential {

    @PrimaryGeneratedColumn({
        name:"id",
        })
    id: number;

    @Column("int",{
        nullable:false,
        name:"UserId",
        })
    userId: number;

    @Column("bigint",{
        nullable:false,
        name:"FacebookId",
        })
    facebookId: string;

}
