import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("cancellationpolicy",{schema:"dbo"})
export class Cancellationpolicy {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"CancellationPolicyID",
        })
    cancellationPolicyId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"CancellationPolicyName",
        })
    cancellationPolicyName: string;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"CancellationPolicyDescription",
        })
    cancellationPolicyDescription: string | null;

    @Column("int",{
        nullable:true,
        name:"HoursRequired",
        })
    hoursRequired: number | null;

    @Column("decimal",{
        nullable:true,
        precision:5,
        scale:2,
        name:"CancellationFeeAfter",
        })
    cancellationFeeAfter: number | null;

    @Column("decimal",{
        nullable:true,
        precision:5,
        scale:2,
        name:"CancellationFeeBefore",
        })
    cancellationFeeBefore: number | null;

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

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

}
