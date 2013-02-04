xquery version "1.0";

(: xquery2: for each user list the posts he liked
                      the other usres who also liked that post :)
                      
<ul>
{
	let $nl := "&#10;"
	for $u in doc("BookfaceDB.xml") /DB/Users/User
	return
	<ul>
	{$nl} {data($u/FirstName)}.{data($u/LastName)} likes the posts:
	{
		for $pl in doc("BookfaceDB.xml") /DB/PostLikes/PostLike
		where $u/@UserID = $pl/OwnerID
		return
		<ul>
		{
			for $p in doc("BookfaceDB.xml") /DB/Posts/Post
			where $pl/PostID = $p/@PostID
			return
			<ul>
			{
				for $u1 in doc("BookfaceDB.xml") /DB/Users/User
				where $p/OwnerID = $u1/@UserID
				return
				<ul>
				-"{data($p/Content)}" on {data($u1/FirstName)}.{data($u1/LastName)} 's wall, also liked by:
				{
					for $pl1 in doc("BookfaceDB.xml") /DB/PostLikes/PostLike
					where $pl/PostID = $pl1/PostID
					return
					<ul>
					{
						for $u2 in doc("BookfaceDB.xml") /DB/Users/User
						where $pl1/OwnerID = $u2/@UserID
						return
						<ul>
						{data($u2/FirstName)}.{data($u2/LastName)}
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