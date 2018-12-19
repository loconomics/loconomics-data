import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

import {CalendarEventRecurrencesPeriod} from "./CalendarEventRecurrencesPeriod";
import {CalendarEvent} from "./CalendarEvent"

@Entity("CalendarEventRecurrencesPeriodList",{schema:"dbo"})
export class CalendarEventRecurrencesPeriodList {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type)=>CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarEventRecurrencesPeriodLists,
        {  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" }
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvent | null>;

    @OneToOne((type)=>CalendarEventRecurrencesPeriod, (CalendarEventRecurrencesPeriod)=>CalendarEventRecurrencesPeriod.idRecurrence,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventRecurrencesPeriod: Promise<CalendarEventRecurrencesPeriod | null>;

}
