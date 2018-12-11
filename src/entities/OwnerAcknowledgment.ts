import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Users} from "./users";

@Entity("OwnerAcknowledgment",{schema:"dbo"})
export class OwnerAcknowledgment {

    @OneToOne((type)=>Users, (Users)=>Users.ownerAcknowledgment,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<Users | null>;

    @Column("datetimeoffset",{
        nullable:false,
        name:"DateAcknowledged",
        })
    dateAcknowledged: Date;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"AcknowledgedFromIP",
        })
    acknowledgedFromIp: string;

    @Column("datetimeoffset",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetimeoffset",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"DetectedIPs",
        })
    detectedIPs: string;

}
