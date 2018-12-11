import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Users} from "./users";

@Entity("serviceaddress",{schema:"dbo"})
export class Serviceaddress {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"AddressID",
        })
    addressId: number;

    @OneToOne((type)=>Users, (Users)=>Users.serviceaddress,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<Users | null>;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"ServicesPerformedAtLocation",
        })
    servicesPerformedAtLocation: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"TravelFromLocation",
        })
    travelFromLocation: boolean;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"ServiceRadiusFromLocation",
        })
    serviceRadiusFromLocation: string | null;

    @Column("int",{
        nullable:true,
        default:"((1))",
        name:"TransportType",
        })
    transportType: number | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PreferredAddress",
        })
    preferredAddress: boolean;

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

}
