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

import {CalendarEventRecurrencePeriod} from "./CalendarEventRecurrencePeriod"
import {CalendarEvent} from "./CalendarEvent"

@Entity("CalendarEventRecurrencesPeriodList",{schema:"dbo"})
export class CalendarEventRecurrencePeriodList {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type)=>CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarEventRecurrencePeriodLists,
        {  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" }
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvent | null>;

    @OneToOne(
        (type) => CalendarEventRecurrencePeriod,
        (CalendarEventRecurrencePeriod) => CalendarEventRecurrencePeriod.idRecurrence,
        { onDelete: "CASCADE" ,onUpdate: "CASCADE" }
    )
    calendarEventRecurrencePeriod: Promise<CalendarEventRecurrencePeriod | null>;

}
