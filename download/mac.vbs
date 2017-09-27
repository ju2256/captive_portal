intCount = 0
strMAC   = ""
' We're interested in MAC addresses of physical adapters only
strQuery = "SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionID > ''"

Set objWMIService = GetObject( "winmgmts://./root/CIMV2" )
Set colItems      = objWMIService.ExecQuery( strQuery, "WQL", 48 )

For Each objItem In colItems
    If InStr( strMAC, objItem.MACAddress ) = 0 Then
        strMAC   = strMAC & objItem.MACAddress & " "
        intCount = intCount + 1
    End If
Next

' Remove leading comma
If intCount > 0 Then strMAC = Mid( strMAC, 2 )

Select Case intCount
    Case 0
        WScript.Echo "No MAC Addresses were found"
    Case 1
        TEST = InputBox("Adresse MAC:","Resultat",strMAC)
    Case Else
        TEST = InputBox("Adresses MAC:","Resultat",strMAC)
End Select