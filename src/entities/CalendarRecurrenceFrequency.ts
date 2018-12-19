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

import {CalendarRecurrence} from "./CalendarRecurrence"

@Entity("CalendarReccurrenceFrequency",{schema:"dbo"})
export class CalendarRecurrenceFrequency {

    @PrimaryGeneratedColumn({
        name:"ID",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarRecurrence,
        (CalendarRecurrence) => CalendarRecurrence.calendarRecurrenceFrequencys,
        { onDelete: "CASCADE",onUpdate: "CASCADE" },
    )
    @JoinColumn({ name:"CalendarReccursiveID"})
    calendarRecursive: Promise<CalendarRecurrence | null>;

    @Column("bit",{
        nullable:true,
        name:"ByDay",
        })
    byDay: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"ByHour",
        })
    byHour: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"ByMinute",
        })
    byMinute: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"ByMonth",
        })
    byMonth: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"ByMonthDay",
        })
    byMonthDay: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"BySecond",
        })
    bySecond: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"BySetPosition",
        })
    bySetPosition: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"ByWeekNo",
        })
    byWeekNo: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"ByYearDay",
        })
    byYearDay: boolean | null;

    @Column("int",{
        nullable:true,
        name:"ExtraValue",
        })
    extraValue: number | null;

    @Column("int",{
        nullable:true,
        name:"FrequencyDay",
        })
    frequencyDay: number | null;

    @Column("int",{
        nullable:true,
        name:"DayOfWeek",
        })
    dayOfWeek: number | null;

}
