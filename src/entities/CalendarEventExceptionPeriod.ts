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

import {CalendarEventExceptionPeriodList} from "./CalendarEventExceptionPeriodList"

@Entity("CalendarEventExceptionsPeriod",{schema:"dbo"})
export class CalendarEventExceptionPeriod {

    @OneToOne(
        (type) => CalendarEventExceptionPeriodList,
        (CalendarEventExceptionPeriodList) => CalendarEventExceptionPeriodList.calendarEventExceptionPeriod,
        { primary:true, nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" }
    )
    @JoinColumn({ name:"IdException"})
    idException: Promise<CalendarEventExceptionPeriodList | null>;

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
