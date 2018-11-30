-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-07-15
-- Description:	Delete a user-verification
-- record, if there is one.
-- =============================================
CREATE PROCEDURE DelUserVerification
	@UserID int,
	@VerificationID int,
    @PositionID int = 0
AS
BEGIN
	DELETE FROM userverification
	WHERE UserID = @UserID
		AND VerificationID = @VerificationID
        AND PositionID = @PositionID
END