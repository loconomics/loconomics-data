import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("alert",{schema:"dbo"})
export class Alert {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"AlertID",
        })
    alertId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"AlertTypeID",
        })
    alertTypeId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:false,
        length:30,
        name:"AlertName",
        })
    alertName: string;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"AlertHeadlineDisplay",
        })
    alertHeadlineDisplay: string | null;

    @Column("varchar",{
        nullable:false,
        length:300,
        name:"AlertTextDisplay",
        })
    alertTextDisplay: string;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"AlertDescription",
        })
    alertDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"AlertEmailText",
        })
    alertEmailText: string | null;

    @Column("int",{
        nullable:false,
        name:"ProviderProfileCompletePoints",
        })
    providerProfileCompletePoints: number;

    @Column("int",{
        nullable:false,
        name:"CustomerProfileCompletePoints",
        })
    customerProfileCompletePoints: number;

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
        nullable:true,
        length:2000,
        name:"AlertPageURL",
        })
    alertPageUrl: string | null;

    @Column("bit",{
        nullable:false,
        name:"Required",
        })
    required: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PositionSpecific",
        })
    positionSpecific: boolean;

    @Column("int",{
        nullable:false,
        default:"((1))",
        name:"DisplayRank",
        })
    displayRank: number;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"ProviderAlert",
        })
    providerAlert: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"CustomerAlert",
        })
    customerAlert: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"bookMeButtonRequired",
        })
    bookMeButtonRequired: boolean;

}
