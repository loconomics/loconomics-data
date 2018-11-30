
CREATE PROC dbo.[ZZIsUserAProvider]

@UserID int

As

select 

count(*) As answer
from users a 
where
	a.UserID = @UserID
	 AND
	a.IsProvider = 1