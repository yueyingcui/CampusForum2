xquery version "1.0";

(: xquery3: find the user with the highest number of friends :) 

<ul>
{
	let $nl :=  "&#10;"
	let $maxf := max(for $u in doc("BookfaceDB.xml") /DB/Users/User
									return 
									<ul>
									{
										let $fs := for $f in doc("BookfaceDB.xml") /DB/Friends/Friend
														 where $u/@UserID = $f/OwnerID
														 return $f                
										return count($fs)
									}
									</ul>)
	return 
	<ul>
	{
		for $u in doc("BookfaceDB.xml") /DB/Users/User
		return
		<ul>
		{
			let $fs := for $f in doc("BookfaceDB.xml") /DB/Friends/Friend
														 where $u/@UserID = $f/OwnerID
														 return $f           
			return
			if (count($fs) eq $maxf)
			then 
				<ul>
				{$nl} {data($u/FirstName)} {data($u/LastName)} has {data($maxf)} friends.
				</ul>
			else ()
		}
		</ul>
	}
	</ul>
}
</ul>