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

@Entity("CalendarEventType",{schema:"dbo"})
export class CalendarEventType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"EventTypeId",
        })
    eventTypeId: number;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"EventType",
        })
    @Expose({name: "InternalName"})
    eventType: string | null;

    @Column("nvarchar",{
        nullable:true,
        name:"Description",
        })
    description: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"DisplayName",
        })
    displayName: string | null;

    @OneToMany(
        (type) => CalendarEvent,
        (CalendarEvent) => CalendarEvent.eventType,
        {onDelete: "CASCADE", onUpdate: "CASCADE"},
    )
    calendarEventss: Promise<CalendarEvent[]>;

}
