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
import {CalendarReccurrenceFrequency} from "./CalendarReccurrenceFrequency";
import {CalendarRecurrenceFrequencyType} from "./CalendarRecurrenceFrequencyType"

@Entity("CalendarReccurrence",{schema:"dbo"})
export class CalendarReccurrence {

    @PrimaryGeneratedColumn({
        name:"ID",
        })
    id: number;

    @ManyToOne((type)=>CalendarEvents, (CalendarEvents)=>CalendarEvents.calendarReccurrences,{ onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"EventID"})
    event: Promise<CalendarEvents | null>;

    @Column("int",{
        nullable:true,
        name:"Count",
        })
    count: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:50,
        name:"EvaluationMode",
        })
    evaluationMode: string | null;

    @ManyToOne(
        (type) => CalendarRecurrenceFrequencyType,
        (CalendarRecurrenceFrequencyType) => CalendarRecurrenceFrequencyType.calendarReccurrences,
    )
    @JoinColumn({ name:"Frequency"})
    frequency: Promise<CalendarRecurrenceFrequencyType | null>;

    @Column("int",{
        nullable:true,
        name:"Interval",
        })
    interval: number | null;

    @Column("int",{
        nullable:true,
        name:"RestristionType",
        })
    restristionType: number | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"Until",
        })
    until: Date | null;

    @Column("int",{
        nullable:true,
        name:"FirstDayOfWeek",
        })
    firstDayOfWeek: number | null;

    @OneToMany((type)=>CalendarReccurrenceFrequency, (CalendarReccurrenceFrequency)=>CalendarReccurrenceFrequency.calendarReccursive,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarReccurrenceFrequencys: Promise<CalendarReccurrenceFrequency[]>;

}
