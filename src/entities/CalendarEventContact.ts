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

@Entity("CalendarEventsContacts",{schema:"dbo"})
export class CalendarEventContact {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarEventContacts,
        { nullable: false ,onDelete: "CASCADE",onUpdate: "CASCADE" },
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvent | null>;

    @Column("nvarchar",{
        nullable:true,
        length:500,
        name:"Contact",
        })
    contact: string | null;

}
