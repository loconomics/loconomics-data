import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarReccurrence} from "./CalendarReccurrence";

@Entity("CalendarRecurrenceFrequencyTypes",{schema:"dbo"})
export class CalendarRecurrenceFrequencyTypes {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ID",
        })
    id: number;

    @Column("nvarchar",{
        nullable:true,
        length:30,
        name:"FrequencyType",
        })
    frequencyType: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:30,
        name:"UnitPlural",
        })
    unitPlural: string | null;

    @OneToMany((type)=>CalendarReccurrence, (CalendarReccurrence)=>CalendarReccurrence.frequency)
    calendarReccurrences: Promise<CalendarReccurrence[]>;

}
