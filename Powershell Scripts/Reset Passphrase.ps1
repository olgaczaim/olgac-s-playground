#You decide to add a new Web Front End to the farm but can’t remember passphrase?
#Here is the solution

Get-Help Set-SPPassPhrase -Detailed

#Shows detailed information about Set-SPPassPhrase such as syntax, description and parameters.

#To easily reset your SharePoint Passphrase:

$passphrase = ConvertTo-SecureString -String “choosepassword” -asPlainText -Force
Set-SPPassPhrase -PassPhrase $passphrase -Confirm

#ps: You should be running this through SharePoint Management Shell and the computer must be in the server farm.