xquery version "1.0";

 (: xquery4: list all the connections up to three levels down of a user his friends
                      his friends' friends
                      their friends :)
                      
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
			{$nl} {data($u1/FirstName)}.{data($u1/LastName)} {$nl} {$sp} {data($u1/FirstName)}.{data($u1/LastName)}'s friends:
			{
				for $f1 in doc ("BookfaceDB.xml") /DB/Friends/Friend
				where $u1/@UserID = $f1/OwnerID
				return
				<ul>
				{
					for $u2 in doc("BookfaceDB.xml") /DB/Users/User
					where $f1/UserID = $u2/@UserID
					return
					<ul>
					{data($u2/FirstName)}.{data($u2/LastName)},
					</ul>
				}
				</ul>
			}
					their friends:
			{
				for $ff1 in doc("BookfaceDB.xml") /DB/Friends/Friend
				where $u1/@UserID = $ff1/OwnerID
				return
				<ul>
				{
					for $uu2 in doc("BookfaceDB.xml") /DB/Users/User
					where $ff1/UserID = $uu2/@UserID
					return
					<ul>
					{
						for $ff in doc("BookfaceDB.xml") /DB/Friends/Friend
						where $u/@UserID = $ff/OwnerID
						return 
						<ul>
						{
							for $uu1 in doc("BookfaceDB.xml") /DB/Users/User
							where $ff/UserID = $uu1/@UserID and $uu1/@UserID = $uu2/@UserID
							return
							<ul>
							{data($uu1/FirstName)}.{data($uu1/LastName)}
							</ul>
						}
						</ul>
					}
					</ul>
				}
				</ul>	
			}
			</ul>
		}
		</ul>
	}
	</ul>
}
</ul>	