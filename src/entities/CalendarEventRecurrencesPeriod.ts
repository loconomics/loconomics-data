import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarEventRecurrencesPeriodList} from "./CalendarEventRecurrencesPeriodList";

@Entity("CalendarEventRecurrencesPeriod",{schema:"dbo"})
export class CalendarEventRecurrencesPeriod {

    @OneToOne((type)=>CalendarEventRecurrencesPeriodList, (CalendarEventRecurrencesPeriodList)=>CalendarEventRecurrencesPeriodList.calendarEventRecurrencesPeriod,{ primary:true, nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"IdRecurrence"})
    idRecurrence: Promise<CalendarEventRecurrencesPeriodList | null>;

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
