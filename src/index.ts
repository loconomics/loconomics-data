import "reflect-metadata"
import {createConnection} from "typeorm"

export default createConnection

export {CalendarAvailabilityType} from "./entities/CalendarAvailabilityType"
export {CalendarEventType} from "./entities/CalendarEventType"
export {CalendarProviderAttribute} from "./entities/CalendarProviderAttribute"
export {JobTitlePlatform} from "./entities/JobTitlePlatform"
export {LicenseCertification} from "./entities/LicenseCertification"
export {Platform} from "./entities/Platform"
export {PostalCode} from "./entities/PostalCode"
export {PostingTemplate} from "./entities/PostingTemplate"
export {PostingTemplateQuestion} from "./entities/PostingTemplateQuestion"
export {Question} from "./entities/Question"
export {ServiceProfessionalClient} from "./entities/ServiceProfessionalClient"
export {Specialization} from "./entities/Specialization"
export {StateProvince} from "./entities/StateProvince"
export {User} from "./entities/User"
export {UserLicenseCertification} from "./entities/UserLicenseCertification"
export {UserOrganization} from "./entities/UserOrganization"
export {UserProfile} from "./entities/UserProfile"
export {WebpageRole} from "./entities/WebpageRole"
export {XJobTitlePricing} from "./entities/XJobTitlePricing"
export {XJobTitleReviewRule} from "./entities/XJobTitleReviewRule"
export {XServiceProfessionalPricing} from "./entities/XServiceProfessionalPricing"
