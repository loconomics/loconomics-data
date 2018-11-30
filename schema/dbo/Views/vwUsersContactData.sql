﻿-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-02-27
-- Description:	Gets users records with some
-- common extra information and its contact
-- and location data, getting location from
-- its address list that is assigned as 'home'
-- location.
-- =============================================
CREATE VIEW vwUsersContactData AS

    SELECT
        -- Basic data
        a.UserID
        ,UP.Email
        ,a.CreatedDate As MemberSinceDate

        -- Name
        ,FirstName
        ,LastName
        ,SecondLastName
        ,MiddleIn
        ,(dbo.fx_concat(dbo.fx_concat(dbo.fx_concat(FirstName, dbo.fx_concatBothOrNothing(MiddleIn, '.', ''), ' '), LastName, ' '), SecondLastName, ' ')) As FullName
    
        -- DEPRECATED PHOTO
        ,Photo

        -- User Type
        ,coalesce(IsAdmin, cast(0 as bit)) As IsAdmin
        ,IsCustomer
        ,IsProvider
        ,AccountStatusID

        -- Only Providers:
        ,(CASE WHEN IsProvider=1 AND (
            SELECT count(*) FROM UserProfilePositions As UPS WHERE UPS.UserID = A.UserID AND UPS.Active=1
            ) > 0 THEN Cast(1 As bit)
            ELSE Cast(0 As bit)
        END) As IsActiveProvider

        ,ProviderWebsiteURL
        ,ProviderProfileURL

        -- Contact data
        ,MobilePhone
        ,AlternatePhone
    
        -- Address
        ,L.AddressLine1
        ,L.AddressLine2
        ,L.City
        ,L.StateProvinceID
        ,SP.StateProvinceName
        ,SP.StateProvinceCode
        ,L.CountryID
        ,PC.PostalCode
        ,L.PostalCodeID

        -- Personal data
        ,PublicBio
        ,A.GenderID
        ,GenderSingular
        ,GenderPlural
        ,SubjectPronoun
        ,ObjectPronoun
        ,PossesivePronoun
                                    
        -- Some preferences
        ,PreferredLanguageID
        ,PreferredCountryID
        ,IAuthZumigoVerification
        ,IAuthZumigoLocation

    FROM Users A
         INNER JOIN
        UserProfile As UP
          ON UP.UserID = A.UserID
         INNER JOIN
        Gender As G
          ON G.GenderID = A.GenderID
          	AND G.LanguageID = A.PreferredLanguageID  
          	AND G.CountryID = A.PreferredCountryID                                
         LEFT JOIN
        Address As L
          ON L.UserID = A.UserID
            AND L.AddressTypeID = 1 -- Only one address with type 1 (home) can exists
         LEFT JOIN
        StateProvince As SP
          ON SP.StateProvinceID = L.StateProvinceID
         LEFT JOIN
        PostalCode As PC
          ON PC.PostalCodeID = L.PostalCodeID