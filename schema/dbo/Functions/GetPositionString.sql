CREATE FUNCTION dbo.GetPositionString ( @UserID INT,@Language INT INT, @PositionCnt INT )

RETURNS VARCHAR(8000) AS BEGIN

        DECLARE @r VARCHAR(8000), @l VARCHAR(8000)

        SELECT @PositionCnt = @PositionCnt - 1,  @r = a.PositionSingular + ', '
          FROM positions a
          JOIN dbo.userprofilepositions up
              on a.positionid = up.PositionID
              AND a.Language = up.Language
        WHERE up.UserID = @UserID and up.Language = @Language
        
              
           AND @PositionCnt = ( SELECT COUNT(*) FROM positions a2
                          JOIN dbo.userprofilepositions up2
                          on a2.positionid = up2.PositionID
                          AND a2.Language = up2.Language
                       WHERE up.UserID = up2.UserID
                         AND a.PositionSingular <= a2.PositionSingular 
                         AND up.Language = up2.Language
                    ) ;
        IF @PositionCnt > 0 BEGIN
              EXEC @l = dbo.GetPositionString @UserID, @Language, @PositionCnt ;
              SET @r =  @l + @r ;
END
RETURN @r ;
END
