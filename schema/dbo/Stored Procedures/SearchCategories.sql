




CREATE PROC [dbo].[SearchCategories]

@LanguageID int = 1,
@CountryID int  = 1,
@ServiceCategoryID int = 1
as

--exec [dbo].[SearchCategories]

select  
ServiceSubCategoryID,
Name,
Rank as ServiceRank
from dbo.servicesubcategory
where LanguageID = @LanguageID and CountryID = @CountryID
and ServiceCategoryID = @ServiceCategoryID
and rank <=5



--b.positionid,  
--a.PositionSingular  as position  
--from positions a join servicecategoryposition  b   
--on a.positionid = b.positionid  
--join servicesubcategory c  on b.ServiceSubCategoryID = c.ServiceSubCategoryID    
--where a.LanguageID = @LanguageID and a.CountryID = @CountryID