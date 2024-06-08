<head>
<meta http-equiv="content-type" content="text.html;charset=utf-8">
</head>
<cfhttp method="post" url="1.1.1.1">
<cfloop collection="#Form#" item="key">
<cfhttpparam type="Formfield" value="#Form[key]#" name="#key#">
</cfloop>
</cfhttp>
<CFOUTPUT>
#cfhttp.filecontent#
</CFOUTPUT>