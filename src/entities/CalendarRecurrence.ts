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
import {CalendarRecurrenceFrequency} from "./CalendarRecurrenceFrequency"
import {CalendarRecurrenceFrequencyType} from "./CalendarRecurrenceFrequencyType"

@Entity("CalendarReccurrence",{schema:"dbo"})
export class CalendarRecurrence {

    @PrimaryGeneratedColumn({
        name:"ID",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarRecurrences,
        { onDelete: "CASCADE",onUpdate: "CASCADE" },
    )
    @JoinColumn({ name:"EventID"})
    event: Promise<CalendarEvent | null>;

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
        (CalendarRecurrenceFrequencyType) => CalendarRecurrenceFrequencyType.calendarRecurrences,
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

    @OneToMany(
        (type) => CalendarRecurrenceFrequency,
        (CalendarRecurrenceFrequency) => CalendarRecurrenceFrequency.calendarRecursive,
        { onDelete: "CASCADE" ,onUpdate: "CASCADE" },
    )
    calendarRecurrenceFrequencys: Promise<CalendarRecurrenceFrequency[]>;

}
