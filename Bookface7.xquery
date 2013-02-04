xquery version "1.0";

(: xquery7: produce a summary listing of revenue generated by a particular user
                     list the set of products bought buy a user and their total :)
                        
<ul>
{
	let $nl := "&#10;"
	for $u  in doc("BookfaceDB.xml") /DB/Users/User 
	return
	<ul>
	{$nl} {data($u/FirstName)}.{data($u/LastName)}'s purchase list:
	{
		for $t in doc("BookfaceDB.xml") /DB/Transactions/Transaction
		where $u/@UserID = $t/OwnerID
		return
		<ul>
		{
			for $a in doc("BookfaceDB.xml") /DB/Advertisements/Advertisement
			where $t/AdvertisementID = $a/@AdvertisementID
			return
			<ul>
			{$nl} ItemName: {data($a/ItemName)} {$nl} Type: {data($a/Type)} {$nl} Company: {data($a/Company)} {$nl} UnitPrice: {data($a/UnitPrice)} {$nl} Number of Units: {data($t/NumberofUnits)} {$nl} Date: {data($t/DateTime)}
			</ul>
		}
		</ul>
	}
	{
		let $r := for $t in doc("BookfaceDB.xml") /DB/Transactions/Transaction
					   where $u/@UserID = $t/OwnerID
					   return for $a in doc("BookfaceDB.xml") /DB/Advertisements/Advertisement
								   where $t/AdvertisementID = $a/@AdvertisementID
								   return $t/NumberofUnits*$a/UnitPrice
		return
		<ul>
		{$nl} Total revenue: {sum($r)}
		</ul>
	}
	</ul>
}
</ul>                       