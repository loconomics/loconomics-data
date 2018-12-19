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

import {CalendarEventExceptionPeriod} from "./CalendarEventExceptionPeriod"
import {CalendarEvent} from "./CalendarEvent"

@Entity("CalendarEventExceptionsPeriodsList",{schema:"dbo"})
export class CalendarEventExceptionPeriodList {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarEventExceptionPeriodLists,
        {  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" }
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvent | null>;

    @OneToOne(
        (type) => CalendarEventExceptionPeriod,
        (CalendarEventExceptionPeriod) => CalendarEventExceptionPeriod.idException,
        { onDelete: "CASCADE" ,onUpdate: "CASCADE" }
    )
    calendarEventExceptionPeriod: Promise<CalendarEventExceptionPeriod | null>;

}
