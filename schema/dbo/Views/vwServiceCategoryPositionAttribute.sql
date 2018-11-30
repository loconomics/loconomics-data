CREATE VIEW [vwServiceCategoryPositionAttribute] AS

	SELECT TOP 100 PERCENT
		d.PositionID
		,se.ServiceAttributeCategoryID
		,s.ServiceAttributeID
		,s.LanguageID
		,s.CountryID
		
		,d.Active As ServiceCategoryPositionAttributeActive
		,s.Active As ServiceAttributeActive
		,se.Active As ServiceAttributeCategoryActive
		
		,s.SourceID As ServiceAttributeSourceID
		,s.Name As ServiceAttributeName
		,s.ServiceAttributeDescription
		
		,s.DisplayRank As ServiceAttributeDisplayRank
		
		,se.ServiceAttributeCategory
		,se.ServiceAttributeCategoryDescription
		
		,se.SourceID As ServiceAttributeCategorySourceID
		,se.PricingOptionCategory
		,se.RequiredInput As ServiceAttributeCategoryRequiredInput
		,se.EligibleForPackages
		,se.SideBarCategory
		,se.DisplayRank As ServiceAttributeCategoryDisplayRank

	FROM servicecategorypositionattribute d
	  join serviceattribute s 
	  on d.ServiceAttributeID = s.ServiceAttributeID 
	  join serviceattributecategory se 
	  on d.ServiceAttributeCategoryID = se.ServiceAttributeCategoryID 
	  and d.LanguageID = se.LanguageID
	  and d.CountryID = se.CountryID
	  and se.LanguageID = s.LanguageID
	  and se.CountryID = s.CountryID

	ORDER BY s.DisplayRank ASC, s.Name ASC