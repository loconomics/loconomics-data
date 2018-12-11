import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("OwnerStatusHistory",{schema:"dbo"})
export class OwnerStatusHistory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserID",
        })
    userId: number;

    @Column("datetime",{
        nullable:false,
        primary:true,
        name:"OwnerStatusChangedDate",
        })
    ownerStatusChangedDate: Date;

    @Column("int",{
        nullable:false,
        name:"OwnerStatusID",
        })
    ownerStatusId: number;

    @Column("varchar",{
        nullable:false,
        length:3,
        name:"OwnerStatusChangedBy",
        })
    ownerStatusChangedBy: string;

}
