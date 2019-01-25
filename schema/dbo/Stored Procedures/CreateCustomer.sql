-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 16/04/2012
-- Description:	Create a Loconomics User as
-- only Customer profile and minimum information
-- (from the Register page or Facebook Login).
-- =============================================
CREATE PROCEDURE [dbo].[CreateCustomer]
	-- Add the parameters for the stored procedure here
	
		@UserID int,
		@Firstname varchar(45),
        @Lastname varchar(145),
		@Lang nvarchar(42),
		@CountryCode nvarchar(2),
        @GenderID int = -1,
		@PublicBio varchar(500) = null,
		@Phone varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO dbo.users (
		UserID,
		FirstName,
		LastName,
		MiddleIn,
		SecondLastName,
		GenderID,
		PreferredLanguage,
		SignupCountryCode,
		PublicBio,
		IsProvider,
		IsCustomer,
		MobilePhone,
		CreatedDate,
		UpdatedDate,
		ModifiedBy,
		Active,
		TrialEndDate
	) VALUES (
		@UserID,
		@Firstname,
		@Lastname,
		'',
		'',
		coalesce(@GenderID, -1),
		@Lang,
		@CountryCode,
		@PublicBio,
		0,
		1,
		@Phone,
		GETDATE(),
		GETDATE(),
		'SYS',
		1,
		DATEADD(DAY, 14, SYSDATETIMEOFFSET())
	)
	
	-- Check alerts for the user to get its state updated
	EXEC TestAllUserAlerts @UserID
END
