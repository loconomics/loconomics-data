import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Users} from "./users";

@Entity("OwnerStatus",{schema:"dbo"})
export class OwnerStatus {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"OwnserStatusID",
        })
    ownserStatusId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"OwnerStatusName",
        })
    ownerStatusName: string;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"OwnerStatusDescription",
        })
    ownerStatusDescription: string | null;

    @Column("datetime",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("varchar",{
        nullable:true,
        length:3,
        name:"UpdatedBy",
        })
    updatedBy: string | null;

    @OneToMany((type)=>Users, (Users)=>Users.ownerStatus)
    userss: Promise<Users[]>;

}
