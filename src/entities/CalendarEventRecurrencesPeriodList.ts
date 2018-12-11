import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarEventRecurrencesPeriod} from "./CalendarEventRecurrencesPeriod";
import {CalendarEvents} from "./CalendarEvents";

@Entity("CalendarEventRecurrencesPeriodList",{schema:"dbo"})
export class CalendarEventRecurrencesPeriodList {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne((type)=>CalendarEvents, (CalendarEvents)=>CalendarEvents.calendarEventRecurrencesPeriodLists,{  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvents | null>;

    @OneToOne((type)=>CalendarEventRecurrencesPeriod, (CalendarEventRecurrencesPeriod)=>CalendarEventRecurrencesPeriod.idRecurrence,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventRecurrencesPeriod: Promise<CalendarEventRecurrencesPeriod | null>;

}
