import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("webpages_Membership",{schema:"dbo"})
export class WebpagesMembership {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserId",
        })
    userId: number;

    @Column("datetime",{
        nullable:true,
        name:"CreateDate",
        })
    createDate: Date | null;

    @Column("nvarchar",{
        nullable:true,
        length:128,
        name:"ConfirmationToken",
        })
    confirmationToken: string | null;

    @Column("bit",{
        nullable:true,
        default:"((0))",
        name:"IsConfirmed",
        })
    isConfirmed: boolean | null;

    @Column("datetime",{
        nullable:true,
        name:"LastPasswordFailureDate",
        })
    lastPasswordFailureDate: Date | null;

    @Column("int",{
        nullable:false,
        default:"((0))",
        name:"PasswordFailuresSinceLastSuccess",
        })
    passwordFailuresSinceLastSuccess: number;

    @Column("nvarchar",{
        nullable:false,
        length:128,
        name:"Password",
        })
    password: string;

    @Column("datetime",{
        nullable:true,
        name:"PasswordChangedDate",
        })
    passwordChangedDate: Date | null;

    @Column("nvarchar",{
        nullable:false,
        length:128,
        name:"PasswordSalt",
        })
    passwordSalt: string;

    @Column("nvarchar",{
        nullable:true,
        length:128,
        name:"PasswordVerificationToken",
        })
    passwordVerificationToken: string | null;

    @Column("datetime",{
        nullable:true,
        name:"PasswordVerificationTokenExpirationDate",
        })
    passwordVerificationTokenExpirationDate: Date | null;

}
