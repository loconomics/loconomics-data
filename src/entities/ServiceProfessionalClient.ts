import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Booking} from "./booking";
import {ReferralSource} from "./ReferralSource";
import {UserEarningsEntry} from "./UserEarningsEntry";
import {Users} from "./users";

@Entity("ServiceProfessionalClient",{schema:"dbo"})
export class ServiceProfessionalClient {

    @OneToOne((type)=>Users, (Users)=>Users.serviceProfessionalClient,{ primary:true, nullable:false })
    @JoinColumn({ name:"ServiceProfessionalUserID"})
    serviceProfessionalUser: Promise<Users | null>;

    @OneToOne((type)=>Users, (Users)=>Users.serviceProfessionalClient2,{ primary:true, nullable:false })
    @JoinColumn({ name:"ClientUserID"})
    clientUser: Promise<Users | null>;

    @Column("ntext",{
        nullable:false,
        default:"('')",
        name:"NotesAboutClient",
        })
    notesAboutClient: string;

    @ManyToOne((type)=>ReferralSource, (ReferralSource)=>ReferralSource.serviceProfessionalClients,{  nullable:false })
    @JoinColumn({ name:"ReferralSourceID"})
    referralSource: Promise<ReferralSource | null>;

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

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @ManyToOne((type)=>Booking, (Booking)=>Booking.serviceProfessionalClients,{  })
    @JoinColumn({ name:"CreatedByBookingID"})
    createdByBooking: Promise<Booking | null>;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"DeletedByServiceProfessional",
        })
    deletedByServiceProfessional: boolean;

    @OneToOne((type)=>UserEarningsEntry, (UserEarningsEntry)=>UserEarningsEntry.user)
    userEarningsEntry: Promise<UserEarningsEntry | null>;

    @OneToMany((type)=>UserEarningsEntry, (UserEarningsEntry)=>UserEarningsEntry.clientUser)
    userEarningsEntrys: Promise<UserEarningsEntry[]>;

}
