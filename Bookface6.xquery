xquery version "1.0";

  (: xquery6: Construct the mailbox of  a given user: list all emails with Message ID, Date, Subject, Sender and Receivers
                       number of replies to each message :)
                       
<ul>
{
	let $nl := "&#10;" 
	for $u in doc("BookfaceDB.xml") /DB/Users/User
	return
	<ul>
	{$nl} {data($u/FirstName)}.{data($u/LastName)} has the message: {$nl} Sent Email:
	{
		for $m in doc("BookfaceDB.xml") /DB/Messages/Message
		where $u/@UserID = $m/SenderID
		return
		<ul>
		{$nl} MessageID: {data($m/@MessageID)} {$nl} Subject: {data($m/Subject)} {$nl} Content: "{data($m/Content)}" {$nl} Date: {data($m/DateTime)}  {$nl} Sender: {data($u/FirstName)}.{data($u/LastName)} {$nl} Receiver: 
		{
			for $mr in doc("BookfaceDB.xml") /DB/MessageReceivers/MessageReceiver
			where $m/@MessageID = $mr/MessageID
			return
			<ul>
			{
				for $u1 in doc("BookfaceDB.xml") /DB/Users/User
				where $mr/ReceiverID = $u1/@UserID
				return
				<ul>
	{data($u1/FirstName)}.{data($u1/LastName)}, 
				</ul>
			}
			</ul>
		}
		{
			let $mcs := for $mc in doc("BookfaceDB.xml") /DB/MComments/MComment
								  where $m/@MessageID = $mc/MessageID
								  return $mc
			return
			<ul>
			{$nl} It has {count($mcs/@MCommentID)} replies.
			</ul>
		}
		</ul>
	}
	{$nl} Inbox: 
	{
		for $mr in doc("BookfaceDB.xml") /DB/MessageReceivers/MessageReceiver
		where $u/@UserID = $mr/ReceiverID
		return
		<ul>
		{
			for $m in doc("BookfaceDB.xml") /DB/Messages/Message
			where $mr/MessageID = $m/@MessageID
			return
			<ul>
			{
				for $u1 in doc("BookfaceDB.xml") /DB/Users/User
				where $m/SenderID = $u1/@UserID
				return
				<ul>
				{$nl} MessageID: {data($m/@MessageID)} {$nl} Subject: {data($m/Subject)} {$nl} Content: "{data($m/Content)}" {$nl} Date: {data($m/DateTime)} {$nl} Sender: {data($u1/FirstName)}.{data($u1/LastName)} {$nl} Receiver: 
				{
					for $mr1 in doc("BookfaceDB.xml") /DB/MessageReceivers/MessageReceiver
					where $m/@MessageID = $mr1/MessageID
					return
					<ul>
					{
						for $u2 in doc("BookfaceDB.xml") /DB/Users/User
						where $mr1/ReceiverID = $u2/@UserID
						return
						<ul>
	{data($u2/FirstName)}.{data($u2/LastName)}, 
						</ul>
					}
					</ul>
				}
				{
					let $mcs := for $mc in doc("BookfaceDB.xml") /DB/MComments/MComment
										  where $m/@MessageID = $mc/MessageID
										  return $mc
					return
					<ul>
					{$nl} It has {count($mcs/@MCommentID)} replies.
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