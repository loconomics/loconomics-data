import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarEventExceptionsPeriod} from "./CalendarEventExceptionsPeriod";
import {CalendarEvents} from "./CalendarEvents";

@Entity("CalendarEventExceptionsPeriodsList",{schema:"dbo"})
export class CalendarEventExceptionsPeriodsList {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne((type)=>CalendarEvents, (CalendarEvents)=>CalendarEvents.calendarEventExceptionsPeriodsLists,{  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvents | null>;

    @OneToOne((type)=>CalendarEventExceptionsPeriod, (CalendarEventExceptionsPeriod)=>CalendarEventExceptionsPeriod.idException,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventExceptionsPeriod: Promise<CalendarEventExceptionsPeriod | null>;

}
