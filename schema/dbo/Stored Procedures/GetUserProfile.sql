-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.GetUserProfile
	-- Add the parameters for the stored procedure here
	@UserID int,
	@PositionID int,
	@LanguageID int = 1,
	@CountryID int = 1

-- exec getuserprofile 2,14

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
			SELECT 
			FirstName + ' ' + LastName as ProviderName,
			PostalCode,
			Photo,
			PreferredLanguageID,
			PreferredCountryID,
			ADD_Details 
			FROM users a 
			JOIN dbo.userprofilepositionadditional b 
			ON a.userid = b.userid  
			WHERE a.UserID = @UserID
			and b.PositionID = @PositionID
			and b.LanguageID = @LanguageID
			and b.CountryID = @CountryID

END