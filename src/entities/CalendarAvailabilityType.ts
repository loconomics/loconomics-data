import {Expose} from "class-transformer"
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

import {CalendarEvent} from "./CalendarEvent"

@Entity("CalendarAvailabilityType",{schema:"dbo"})
export class CalendarAvailabilityType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"CalendarAvailabilityTypeID",
        })
    @Expose({name: "AvailabilityTypeID"})
    calendarAvailabilityTypeId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

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
    @Expose({name: "DisplayName"})
    selectableAs: string | null;

    @OneToMany(
        (type)=>CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarAvailabilityType,
        {onDelete: "CASCADE", onUpdate: "CASCADE"},
    )
    calendarEventss: Promise<CalendarEvent[]>;

}
