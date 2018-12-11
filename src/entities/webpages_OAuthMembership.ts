import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("webpages_OAuthMembership",{schema:"dbo"})
export class WebpagesOAuthMembership {

    @Column("nvarchar",{
        nullable:false,
        primary:true,
        length:30,
        name:"Provider",
        })
    provider: string;

    @Column("nvarchar",{
        nullable:false,
        primary:true,
        length:100,
        name:"ProviderUserId",
        })
    providerUserId: string;

    @Column("int",{
        nullable:false,
        name:"UserId",
        })
    userId: number;

}
