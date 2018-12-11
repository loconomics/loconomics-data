import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("providerpackagedetail",{schema:"dbo"})
export class Providerpackagedetail {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ProviderPackageID",
        })
    providerPackageId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceAttributeID",
        })
    serviceAttributeId: number;

    @Column("datetime",{
        nullable:false,
        default:"('sysdate')",
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:false,
        default:"('sysdate')",
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("varchar",{
        nullable:false,
        length:25,
        default:"('sys')",
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

}
