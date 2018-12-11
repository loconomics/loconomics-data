import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarEventExceptionsPeriodsList} from "./CalendarEventExceptionsPeriodsList";

@Entity("CalendarEventExceptionsPeriod",{schema:"dbo"})
export class CalendarEventExceptionsPeriod {

    @OneToOne((type)=>CalendarEventExceptionsPeriodsList, (CalendarEventExceptionsPeriodsList)=>CalendarEventExceptionsPeriodsList.calendarEventExceptionsPeriod,{ primary:true, nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"IdException"})
    idException: Promise<CalendarEventExceptionsPeriodsList | null>;

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
