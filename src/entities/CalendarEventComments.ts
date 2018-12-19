import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {CalendarEvent} from "./CalendarEvent"

@Entity("CalendarEventComments",{schema:"dbo"})
export class CalendarEventComments {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @ManyToOne(
        (type) => CalendarEvent,
        (CalendarEvent) => CalendarEvent.calendarEventCommentss,
        {  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" }
    )
    @JoinColumn({ name:"IdEvent"})
    idEvent: Promise<CalendarEvent | null>;

    @Column("nvarchar",{
        nullable:true,
        name:"Comment",
        })
    comment: string | null;

}
