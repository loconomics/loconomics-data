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

import {ServiceSubcategory} from "./ServiceSubcategory";

@Entity("servicecategory",{schema:"dbo"})
export class Servicecategory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceCategoryID",
        })
    serviceCategoryId: number;

    @Column("varchar",{
        nullable:true,
        length:45,
        name:"Name",
        })
    name: string | null;

    @Column("varchar",{
        nullable:true,
        length:350,
        name:"Description",
        })
    description: string | null;

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
        length:2,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"ImagePath",
        })
    imagePath: string | null;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"headline",
        })
    headline: string | null;

    @OneToMany((type) => ServiceSubcategory, (ServiceSubcategory) => ServiceSubcategory.serviceCategory)
    servicesubcategorys: Promise<ServiceSubcategory[]>;

}
