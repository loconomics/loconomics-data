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

@Entity("CalendarEventsAttendees",{schema:"dbo"})
export class CalendarEventAttendee {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarEventAttendees,
        {  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" },
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvent | null>;

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
