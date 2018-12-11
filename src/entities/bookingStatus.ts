import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("bookingStatus",{schema:"dbo"})
export class BookingStatus {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"BookingStatusID",
        })
    bookingStatusId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"BookingStatusName",
        })
    bookingStatusName: string;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"BookingStatusDescription",
        })
    bookingStatusDescription: string | null;

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
