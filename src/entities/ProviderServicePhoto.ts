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

@Entity("providerservicephoto",{schema:"dbo"})
export class ProviderServicePhoto {

    @PrimaryGeneratedColumn({
        name:"ProviderServicePhotoID",
        })
    providerServicePhotoId: number;

    @Column("int",{
        nullable:false,
        name:"UserID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        name:"PositionID",
        })
    positionId: number;

    @Column("varchar",{
        nullable:true,
        length:150,
        name:"PhotoCaption",
        })
    photoCaption: string | null;

    @Column("varchar",{
        nullable:false,
        length:2073,
        name:"PhotoAddress",
        })
    photoAddress: string;

    @Column("int",{
        nullable:false,
        name:"RankPosition",
        })
    rankPosition: number;

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

    @Column("bit",{
        nullable:false,
        name:"IsPrimaryPhoto",
        })
    isPrimaryPhoto: boolean;

}
