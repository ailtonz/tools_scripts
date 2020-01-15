objNetwork = WScript.CreateObject("WScript.Network")
strRemoteShare = "\\saont46\apps4" 
objNetwork.MapNetworkDrive "x:", strRemoteShare, False