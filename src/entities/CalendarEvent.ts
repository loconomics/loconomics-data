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

import {CalendarAvailabilityType} from "./CalendarAvailabilityType"
import {CalendarEventComments} from "./CalendarEventComments";
import {CalendarEventExceptionsPeriodsList} from "./CalendarEventExceptionsPeriodsList";
import {CalendarEventRecurrencesPeriodList} from "./CalendarEventRecurrencesPeriodList";
import {CalendarEventAttendee} from "./CalendarEventAttendee"
import {CalendarEventContact} from "./CalendarEventContact"
import {CalendarEventType} from "./CalendarEventType"
import {CalendarRecurrence} from "./CalendarRecurrence"

@Entity("CalendarEvents",{schema:"dbo"})
export class CalendarEvent {

    @PrimaryGeneratedColumn({
        name:"Id",
        })
    id: number;

    @Column("int",{
        nullable:false,
        name:"UserId",
        })
    userId: number;

    @ManyToOne((type)=>CalendarEventType, (CalendarEventType)=>CalendarEventType.calendarEventss,{  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"EventType"})
    eventType: Promise<CalendarEventType | null>;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"Summary",
        })
    summary: string | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"StarTtime",
        })
    starTtime: Date | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"EndTime",
        })
    endTime: Date | null;

    @Column("varchar",{
        nullable:true,
        length:150,
        name:"UID",
        })
    uid: string | null;

    @ManyToOne((type)=>CalendarAvailabilityType, (CalendarAvailabilityType)=>CalendarAvailabilityType.calendarEventss,{  nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"CalendarAvailabilityTypeID"})
    calendarAvailabilityType: Promise<CalendarAvailabilityType | null>;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"Transparency",
        })
    transparency: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsAllDay",
        })
    isAllDay: boolean;

    @Column("datetimeoffset",{
        nullable:true,
        name:"StampTime",
        })
    stampTime: Date | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"TimeZone",
        })
    timeZone: string | null;

    @Column("int",{
        nullable:true,
        name:"Priority",
        })
    priority: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"Location",
        })
    location: string | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"CreatedDate",
        })
    createdDate: Date | null;

    @Column("nvarchar",{
        nullable:true,
        length:50,
        name:"ModifyBy",
        })
    modifyBy: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:50,
        name:"Class",
        })
    class: string | null;

    @Column("nvarchar",{
        nullable:true,
        name:"Organizer",
        })
    organizer: string | null;

    @Column("int",{
        nullable:true,
        name:"Sequence",
        })
    sequence: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"Geo",
        })
    geo: string | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"RecurrenceId",
        })
    recurrenceId: Date | null;

    @Column("time",{
        nullable:true,
        name:"TimeBlock",
        })
    timeBlock: Date | null;

    @Column("int",{
        nullable:true,
        name:"DayofWeek",
        })
    dayofWeek: number | null;

    @Column("nvarchar",{
        nullable:true,
        name:"Description",
        })
    description: string | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"Deleted",
        })
    deleted: Date | null;

    @OneToMany((type)=>CalendarEventComments, (CalendarEventComments)=>CalendarEventComments.idEvent,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventCommentss: Promise<CalendarEventComments[]>;

    @OneToMany((type)=>CalendarEventExceptionsPeriodsList, (CalendarEventExceptionsPeriodsList)=>CalendarEventExceptionsPeriodsList.idEvent,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventExceptionsPeriodsLists: Promise<CalendarEventExceptionsPeriodsList[]>;

    @OneToMany((type)=>CalendarEventRecurrencesPeriodList, (CalendarEventRecurrencesPeriodList)=>CalendarEventRecurrencesPeriodList.idEvent,{ onDelete: "CASCADE" ,onUpdate: "CASCADE" })
    calendarEventRecurrencesPeriodLists: Promise<CalendarEventRecurrencesPeriodList[]>;

    @OneToMany(
        (type) => CalendarEventAttendee,
        (CalendarEventAttendee) => CalendarEventAttendee.idEvent,
        { onDelete: "CASCADE" ,onUpdate: "CASCADE" }
    )
    calendarEventAttendees: Promise<CalendarEventAttendee[]>;

    @OneToMany(
        (type) => CalendarEventContact,
        (CalendarEventContact) => CalendarEventContact.idEvent,
        { onDelete: "CASCADE" ,onUpdate: "CASCADE" },
    )
    calendarEventContacts: Promise<CalendarEventContact[]>;

    @OneToMany(
        (type) => CalendarRecurrence,
        (CalendarRecurrence) => CalendarRecurrence.event,
        { onDelete: "CASCADE" ,onUpdate: "CASCADE" },
    )
    calendarRecurrences: Promise<CalendarRecurrence[]>;

}
