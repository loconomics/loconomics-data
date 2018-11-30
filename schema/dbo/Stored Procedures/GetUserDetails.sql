




CREATE PROC dbo.GetUserDetails

@UserID int


as




select 

FirstName, 
LastName,
SecondLastName,
MiddleIn,
PostalCode,
Photo,
PreferredLanguageID,
PreferredCountryID,
ADD_Details 
from users a 
join dbo.userprofilepositionadditional b 
on a.userid = b.userid  where a.UserID = @UserID