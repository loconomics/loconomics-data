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

import {CCCUser} from "./CCCUser"

@Entity("FieldOfStudy",{schema:"dbo"})
export class FieldOfStudy {

    @PrimaryGeneratedColumn({
        name:"FieldOfStudyID",
        })
    fieldOfStudyId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"FieldOfStudyName",
        })
    fieldOfStudyName: string;

    @Column("int",{
        nullable:true,
        name:"CCCTOPCode",
        })
    ccctopCode: number | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetime",{
        nullable:true,
        name:"CreatedDate",
        })
    createdDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:10,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @OneToMany(
        (type) => CCCUser,
        (CCCUser) => CCCUser.fieldOfStudy
    )
    cccUsers: Promise<CCCUser[]>;

}
