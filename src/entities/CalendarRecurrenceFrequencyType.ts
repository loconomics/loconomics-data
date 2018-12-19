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

@Entity("CalendarRecurrenceFrequencyTypes",{schema:"dbo"})
export class CalendarRecurrenceFrequencyType {

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

    @OneToMany((type) => CalendarRecurrence, (CalendarRecurrence) => CalendarRecurrence.frequency)
    calendarRecurrences: Promise<CalendarRecurrence[]>;

}
