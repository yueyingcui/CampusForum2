xquery version "1.0";

(: xquery1: for each user list the post he has on the wall
                    replies to these posts
                    replies to replies - represent 2 levels down :)
                    
<ul>
{
	let $nl := "&#10;"
	for $u  in doc("BookfaceDB.xml") /DB/Users/User
	return 
	<ul>
	{data($nl)} {data($u/FirstName)}.{data($u/LastName)} has the posts:
	{
		for $p in doc("BookfaceDB.xml") /DB/Posts/Post
		where $u/@UserID = $p/OwnerID
		return 
		<ul>
		-"{data($p/Content)}" 
		{
			for $c in doc("BookfaceDB.xml") /DB/Comments/Comment
			where $p/@PostID = $c/PostID
			return
			<ul>
			{
				for $u1 in doc("BookfaceDB.xml") /DB/Users/User
				where $c/OwnerID = $u1/@UserID
				return 
				<ul>
				reply by {data($u1/FirstName)}.{data($u1/LastName)}: "{data($c/Content)}"
				{
					for $cc in doc("BookfaceDB.xml") /DB/CComments/CComment
					where $c/@CommentID = $cc/CommentID
					return
					<ul>
					{
						for $u2 in doc("BookfaceDB.xml") /DB/Users/User
						where $cc/OwnerID = $u2/@UserID
						return
						<ul>
						reply to {data($u1/FirstName)}.{data($u1/LastName)}'s comment by {data($u2/FirstName)}.{data($u2/LastName)}: {data($cc/Content)}
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
 