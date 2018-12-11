import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarEvents} from "./CalendarEvents";

@Entity("CalendarEventType",{schema:"dbo"})
export class CalendarEventType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"EventTypeId",
        })
    eventTypeId: number;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"EventType",
        })
    eventType: string | null;

    @Column("nvarchar",{
        nullable:true,
        name:"Description",
        })
    description: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"DisplayName",
        })
    displayName: string | null;

    @OneToMany((type)=>CalendarEvents, (CalendarEvents)=>CalendarEvents.eventType,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventss: Promise<CalendarEvents[]>;

}
