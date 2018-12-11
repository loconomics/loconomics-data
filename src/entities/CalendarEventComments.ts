import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarEvents} from "./CalendarEvents";

@Entity("CalendarEventComments",{schema:"dbo"})
export class CalendarEventComments {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne((type)=>CalendarEvents, (CalendarEvents)=>CalendarEvents.calendarEventCommentss,{  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvents | null>;

    @Column("nvarchar",{
        nullable:true,
        name:"Comment",
        })
    comment: string | null;

}
