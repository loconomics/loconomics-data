import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("pricingSummaryDetail",{schema:"dbo"})
export class PricingSummaryDetail {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingSummaryID",
        })
    pricingSummaryId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingSummaryRevision",
        })
    pricingSummaryRevision: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceProfessionalServiceID",
        })
    serviceProfessionalServiceId: number;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"ServiceProfessionalDataInput",
        })
    serviceProfessionalDataInput: string | null;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"ClientDataInput",
        })
    clientDataInput: string | null;

    @Column("decimal",{
        nullable:true,
        precision:5,
        scale:2,
        name:"HourlyPrice",
        })
    hourlyPrice: number | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"Price",
        })
    price: number | null;

    @Column("int",{
        nullable:true,
        name:"ServiceDurationMinutes",
        })
    serviceDurationMinutes: number | null;

    @Column("int",{
        nullable:true,
        name:"FirstSessionDurationMinutes",
        })
    firstSessionDurationMinutes: number | null;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"ServiceName",
        })
    serviceName: string;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"ServiceDescription",
        })
    serviceDescription: string | null;

    @Column("int",{
        nullable:false,
        name:"NumberOfSessions",
        })
    numberOfSessions: number;

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
        default:"((0))",
        name:"IsRemoteService",
        })
    isRemoteService: boolean;

}
