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

import {ServiceProfessionalClient} from "./ServiceProfessionalClient"

@Entity("ReferralSource",{schema:"dbo"})
export class ReferralSource {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ReferralSourceID",
        })
    referralSourceId: number;

    @Column("nvarchar",{
        nullable:false,
        length:80,
        name:"Name",
        })
    name: string;

    @OneToMany((type)=>ServiceProfessionalClient, (ServiceProfessionalClient)=>ServiceProfessionalClient.referralSource)
    serviceProfessionalClients: Promise<ServiceProfessionalClient[]>;

}
