
CREATE PROC [dbo].[GetUserCalendarProviderAttributes]

@UserID int


as

SELECT AdvanceTime,MinTime,MaxTime,BetweenTime,UseCalendarProgram,CalendarType,CalendarURL, PrivateCalendarToken, IncrementsSizeInMinutes
FROM CalendarProviderAttributes
WHERE UserID = @UserID