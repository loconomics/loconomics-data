CREATE PROCEDURE DeleteUserPosition (
	@UserID int,
	@PositionID int
) AS BEGIN

delete from [ServiceAttributeLanguageLevel]
where userid = @UserID AND PositionID = @PositionID

delete from ServiceAttributeExperienceLevel
where userid = @UserID AND PositionID = @PositionID

delete from userprofileserviceattributes
where userid = @UserID AND PositionID = @PositionID

delete from userprofilepositions
where userid = @UserID AND PositionID = @PositionID

END