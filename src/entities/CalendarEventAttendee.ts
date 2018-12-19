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

@Entity("CalendarEventsAttendees",{schema:"dbo"})
export class CalendarEventAttendee {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarEvents,
        (CalendarEvents) => CalendarEvents.calendarEventAttendees,
        {  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" },
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvents | null>;

    @Column("nvarchar",{
        nullable:true,
        name:"Attendee",
        })
    attendee: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:50,
        name:"Role",
        })
    role: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:200,
        name:"Uri",
        })
    uri: string | null;

}
