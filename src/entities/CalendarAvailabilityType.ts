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
import {CalendarEvents} from "./CalendarEvents";

@Entity("CalendarAvailabilityType",{schema:"dbo"})
export class CalendarAvailabilityType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"CalendarAvailabilityTypeID",
        })
    calendarAvailabilityTypeId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("int",{
        nullable:false,
        name:"CountryID",
        })
    countryId: number;

    @Column("nvarchar",{
        nullable:false,
        length:50,
        name:"CalendarAvailabilityTypeName",
        })
    calendarAvailabilityTypeName: string;

    @Column("nvarchar",{
        nullable:false,
        length:300,
        name:"CalendarAvailabilityTypeDescription",
        })
    calendarAvailabilityTypeDescription: string;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"UserDescription",
        })
    userDescription: string | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"AddAppointmentType",
        })
    addAppointmentType: boolean;

    @Column("nvarchar",{
        nullable:true,
        length:50,
        name:"SelectableAs",
        })
    selectableAs: string | null;

    @OneToMany(
        (type)=>CalendarEvents,
        (CalendarEvents)=>CalendarEvents.calendarAvailabilityType, {
            onDelete: "CASCADE",
            onUpdate: "CASCADE",
        },
    )
    calendarEventss: Promise<CalendarEvents[]>;

}
