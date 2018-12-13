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

import {User} from "./User"

@Entity("CalendarProviderAttributes",{schema:"dbo"})
export class CalendarProviderAttribute {

    @OneToOne(
        (type) => User,
        (User) => User.calendarProviderAttributes, {
            primary:true,
            nullable: false,
            onDelete: "CASCADE",
            onUpdate: "CASCADE",
        },
    )
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @Column("decimal",{
        nullable:false,
        precision:10,
        scale:2,
        name:"AdvanceTime",
        })
    advanceTime: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:10,
        scale:2,
        name:"MinTime",
        })
    minTime: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:10,
        scale:2,
        name:"MaxTime",
        })
    maxTime: number;

    @Column("decimal",{
        nullable:false,
        precision:10,
        scale:2,
        name:"BetweenTime",
        })
    betweenTime: number;

    @Column("bit",{
        nullable:false,
        name:"UseCalendarProgram",
        })
    useCalendarProgram: boolean;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"CalendarType",
        })
    calendarType: string | null;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"CalendarURL",
        })
    calendarUrl: string | null;

    @Column("varchar",{
        nullable:true,
        length:128,
        name:"PrivateCalendarToken",
        })
    privateCalendarToken: string | null;

    @Column("int",{
        nullable:false,
        default:"((15))",
        name:"IncrementsSizeInMinutes",
        })
    incrementsSizeInMinutes: number;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"TimeZone",
        })
    timeZone: string | null;

}
