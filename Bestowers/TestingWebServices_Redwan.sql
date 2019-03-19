-- MemberID	FirstName	LastName	BatchID	CadetNo	HomeEmail	HomePhone	City	State	CountryID

use BestowersAppDatabase_Old
select MemberID, FirstName, LastName, BatchID, CadetNo, HomeEmail, HomePhone, City, [State], CountryID from member order by ltrim(FirstName)

create procedure Member_Proc
@MemberID int = null,
@FirstName nvarchar(50) = null,
@LastName nvarchar(50) = null,
@BatchID int = null,
@CadetNo int = null,
@HomeEmail nvarchar(50) = null,
@HomePhone nvarchar(50) = null,
@City nvarchar(50) = null,
@State nvarchar(50) = null,
@CountryID nvarchar(50) = null
as
begin
	select MemberID, FirstName, LastName, BatchID, CadetNo, HomeEmail, HomePhone, City, [State], CountryID from Member where
	(MemberID like cast(ltrim(@MemberID) as nvarchar) + '%' or @MemberID is null) and
	(FirstName like @FirstName + '%' or @FirstName is null) and
	(LastName like @LastName + '%' or @LastName is null) and
	(BatchID like cast(ltrim(@BatchID) as nvarchar) + '%' or @BatchID is null) and
	(CadetNo like cast(ltrim(@CadetNo) as nvarchar) + '%' or @CadetNo is null) and
	(HomeEmail like @HomeEmail + '%' or @HomeEmail is null) and
	(HomePhone like @HomePhone + '%' or @HomePhone is null) and
	(City like @City + '%' or @City is null) and
	([State] like @State + '%' or @State is null) and
	(CountryID like @CountryID + '%' or @CountryID is null)
	order by BatchID, cast(CadetNo as int) asc
end

execute Member_Proc 295

create procedure sortData
@data nvarchar(100)
as
begin
	if('-1' = @data)
	begin
		select MemberID, FirstName, LastName, BatchID, CadetNo, HomeEmail, HomePhone, City, [State], CountryID from Member order by
		cast(ltrim(BatchID) as int), cast(ltrim(CadetNo) as int)
	end

	select MemberID, FirstName, LastName, BatchID, CadetNo, HomeEmail, HomePhone, City, [State], CountryID from Member order by
	case when 'memberID' = @data then cast(ltrim(MemberID) as int) end,
	case when 'firstName' = @data then ltrim(FirstName) end,
	case when 'lastName' = @data then ltrim(LastName) end,
	case when 'batchID' = @data then cast(ltrim(BatchID) as int) end,
	case when 'cadetNo' = @data then cast(ltrim(CadetNo) as int) end,
	case when 'homeEmail' = @data then ltrim(HomeEmail) end,
	case when 'homePhone' = @data then ltrim(HomePhone) end,
	case when 'city' = @data then ltrim(City) end,
	case when 'state' = @data then ltrim([State]) end,
	case when 'countryID' = @data then ltrim(CountryID) end

end

sortData 'firstName'

-- {"MemberID":"295","FirstName":"Habibullah","LastName":"Bahar","BatchID":"11","CadetNo":"587","HomeEmail":"smhbahar@hotmail.com","HomePhone":"613-531-6014","City":"Guelph","State":"ON","CountryID":"CA"}