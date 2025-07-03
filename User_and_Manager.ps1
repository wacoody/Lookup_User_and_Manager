#the base query
#get-aduser -searchbase "OU=Users,DC=demo,DC=local" -filter {enabled -eq $true} -properties * | select-object displayname, userprincipalname, manager, distinguishedname | export-csv "$env:userprofile\desktop\users.csv"

#the modified query
get-aduser -searchbase "OU=Users,DC=demo,DC=local" -filter {enabled -eq $true} -properties * | select-object displayname, userprincipalname, @{name="manager";expression={(get-aduser $_.manager).name}},@{name="distinguishedname";expression={$ary=$_.DistinguishedName.split(",");$ary[2].substring(3)}} | export-csv "$env:userprofile\desktop\users.csv"



# https://www.reddit.com/r/PowerShell/comments/znh6uk/how_can_i_get_just_the_managers_name_of_the_ad/
# https://stackoverflow.com/questions/31325725/retrieve-manager-name-for-each-user-in-ad-using-powershell
# https://stackoverflow.com/questions/45685690/powershell-split-user-defined-distinguished-name-into-individual-parts
# https://www.oreilly.com/library/view/mastering-windows-powershell/9781787126305/83c4a866-082f-4df0-8c32-1ffa91a6e329.xhtml
