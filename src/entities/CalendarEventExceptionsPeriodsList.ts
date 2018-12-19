import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

import {CalendarEventExceptionsPeriod} from "./CalendarEventExceptionsPeriod";
import {CalendarEvent} from "./CalendarEvent"

@Entity("CalendarEventExceptionsPeriodsList",{schema:"dbo"})
export class CalendarEventExceptionsPeriodsList {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarEventExceptionsPeriodsLists,
        {  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" }
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvent | null>;

    @OneToOne((type)=>CalendarEventExceptionsPeriod, (CalendarEventExceptionsPeriod)=>CalendarEventExceptionsPeriod.idException,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventExceptionsPeriod: Promise<CalendarEventExceptionsPeriod | null>;

}
