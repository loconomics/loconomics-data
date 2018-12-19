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

import {FieldOfStudy} from "./FieldOfStudy"
import {Institution} from "./Institution"
import {User} from "./User"

@Entity("CCCUsers",{schema:"dbo"})
export class CCCUser {

    @OneToOne(
        (type) => User,
        (User) => User.cccUser,
        { primary:true, nullable:false },
    )
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @ManyToOne(
        (type) => Institution,
        (Institution) => Institution.cccUsers,
        {  },
    )
    @JoinColumn({ name:"InstitutionID"})
    institution: Promise<Institution | null>;

    @ManyToOne(
        (type) => FieldOfStudy,
        (FieldOfStudy) => FieldOfStudy.cccUsers,
        {  },
    )
    @JoinColumn({ name:"FieldOfStudyID"})
    fieldOfStudy: Promise<FieldOfStudy | null>;

    @Column("datetime",{
        nullable:true,
        name:"PlanExpirationDate",
        })
    planExpirationDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"UserType",
        })
    userType: string | null;

    @Column("int",{
        nullable:true,
        name:"StudentID",
        })
    studentId: number | null;

}
