import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

import {FieldOfStudy} from "./FieldOfStudy";
import {Institution} from "./institution";
import {User} from "./User"

@Entity("CCCUsers",{schema:"dbo"})
export class CccUsers {

    @OneToOne((type)=>User, (User)=>User.cCcUsers,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @ManyToOne((type)=>Institution, (Institution)=>Institution.cCcUserss,{  })
    @JoinColumn({ name:"InstitutionID"})
    institution: Promise<Institution | null>;

    @ManyToOne((type)=>FieldOfStudy, (FieldOfStudy)=>FieldOfStudy.cCcUserss,{  })
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
