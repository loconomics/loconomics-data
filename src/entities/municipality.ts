import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {County} from "./county";
import PostalCode from "./PostalCode"

@Entity("municipality",{schema:"dbo"})
export class Municipality {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"MunicipalityID",
        })
    municipalityId: number;

    @ManyToOne((type)=>County, (County)=>County.municipalitys,{  nullable:false })
    @JoinColumn({ name:"CountyID"})
    county: Promise<County | null>;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"MunicipalityName",
        })
    municipalityName: string;

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

    @OneToMany((type)=>PostalCode, (PostalCode)=>PostalCode.municipality)
    postalcodes: Promise<PostalCode[]>;

}
