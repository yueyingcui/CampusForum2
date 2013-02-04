xquery version "1.0";

 (: xquery5: list all friends of a user
                       with their number of friends :)
                       
<ul>
{
	let $nl := "&#10;"
	let $sp := "                    "
	let $sp1 := " "
	for $u  in doc("BookfaceDB.xml") /DB/Users/User
	return
	<ul>
	{$nl} {data($u/FirstName)}.{data($u/LastName)}'s friends:
	{
		for $f in doc("BookfaceDB.xml") /DB/Friends/Friend
		where $u/@UserID = $f/OwnerID
		return
		<ul>
		{
			for $u1 in doc("BookfaceDB.xml") /DB/Users/User
			where $f/UserID = $u1/@UserID
			return
			<ul>
			{$nl} {data($u1/FirstName)}.{data($u1/LastName)} {$nl} {$sp} {data($u1/FirstName)}.{data($u1/LastName)} has 
			{
				let $fs := for $f1 in doc ("BookfaceDB.xml") /DB/Friends/Friend
								where $u1/@UserID = $f1/OwnerID
								return $f1
				return
				<ul>
				{count($fs/UserID)} friends.
				</ul>
			}
			</ul>
		}
		</ul>
	}
	</ul>
}
</ul>	