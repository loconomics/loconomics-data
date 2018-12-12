import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import User from "./User"

@Entity("OwnerAcknowledgment",{schema:"dbo"})
export class OwnerAcknowledgment {

    @OneToOne((type)=>User, (User)=>User.ownerAcknowledgment,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

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
