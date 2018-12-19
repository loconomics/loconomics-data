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

import {CalendarEventRecurrencePeriodList} from "./CalendarEventRecurrencePeriodList"

@Entity("CalendarEventRecurrencesPeriod",{schema:"dbo"})
export class CalendarEventRecurrencePeriod {

    @OneToOne(
        (type) => CalendarEventRecurrencePeriodList,
        (CalendarEventRecurrencePeriodList) => CalendarEventRecurrencePeriodList.calendarEventRecurrencePeriod,
        { primary:true, nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" },
    )
    @JoinColumn({ name:"IdRecurrence"})
    idRecurrence: Promise<CalendarEventRecurrencePeriodList | null>;

    @Column("datetimeoffset",{
        nullable:false,
        primary:true,
        name:"DateStart",
        })
    dateStart: Date;

    @Column("datetimeoffset",{
        nullable:true,
        name:"DateEnd",
        })
    dateEnd: Date | null;

}
