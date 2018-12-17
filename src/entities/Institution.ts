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

import {CccUsers} from "./CCCUsers";
import {StateProvince} from "./StateProvince"
import {UserEducation} from "./UserEducation"

@Entity("institution",{schema:"dbo"})
export class Institution {

    @PrimaryGeneratedColumn({
        name:"InstitutionID",
        })
    institutionId: number;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"DeptOfEdInstitutionID",
        })
    deptOfEdInstitutionId: string | null;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"InstitutionName",
        })
    institutionName: string;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"InstitutionAddress",
        })
    institutionAddress: string | null;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"InstitutionCity",
        })
    institutionCity: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"InstitutionState",
        })
    institutionState: string | null;

    @ManyToOne((type)=>StateProvince, (StateProvince)=>StateProvince.institutions,{  })
    @JoinColumn({ name:"StateProvinceID"})
    stateProvince: Promise<StateProvince | null>;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"InstitutionZip",
        })
    institutionZip: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"InstitutionPhone",
        })
    institutionPhone: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"InstitutionOPEID",
        })
    institutionOpeid: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"InstitutionIPEDSUnitID",
        })
    institutionIpedsUnitId: string | null;

    @Column("varchar",{
        nullable:true,
        length:2083,
        name:"InstitutionURL",
        })
    institutionUrl: string | null;

    @Column("int",{
        nullable:true,
        name:"CountryID",
        })
    countryId: number | null;

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

    @Column("varchar",{
        nullable:true,
        length:3,
        name:"SchoolID",
        })
    schoolId: string | null;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"DistrictName",
        })
    districtName: string | null;

    @Column("varchar",{
        nullable:true,
        length:3,
        name:"DistrictID",
        })
    districtId: string | null;

    @OneToMany((type)=>CccUsers, (CccUsers)=>CccUsers.institution)
    cCcUserss: Promise<CccUsers[]>;

    @OneToMany((type) => UserEducation, (UserEducation) => UserEducation.institution)
    usereducations: Promise<UserEducation[]>;

}
