#tag Class
Class CarbonPasteboard
	#tag Method, Flags = &h0
		Sub Clear()
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardClear lib "Carbon" (ref as Ptr) as Integer
		  
		  mLastError = PasteboardClear (mRef)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Clipboard() As CarbonPasteboard
		  return new CarbonPasteboard()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // default constructor, returning the main clipboard
		  
		  self.Constructor("com.apple.pasteboard.clipboard")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(name as CFStringRef)
		  declare function PasteboardCreate lib "Carbon" (name as CFStringRef, ByRef ref as Ptr) as Integer
		  
		  mLastError = PasteboardCreate (name, mRef)
		  if mLastError <> 0 then
		    raise new NilObjectException
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Destructor()
		  declare sub CFRelease lib "Carbon" (cf as Ptr)
		  CFRelease mRef
		  mRef = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FindPasteboard() As CarbonPasteboard
		  return new CarbonPasteboard("com.apple.pasteboard.find")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemFlavorData(itemID as Ptr, flavor as String) As MemoryBlock
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardCopyItemFlavorData lib "Carbon" (ref as Ptr, id as Ptr, type as CFStringRef, ByRef data as Ptr) as Integer
		  
		  dim d as Ptr
		  mLastError = PasteboardCopyItemFlavorData (mRef, itemID, flavor, d)
		  
		  if mLastError = 0 then
		    dim data as new CFData (d, CFData.hasOwnership)
		    return data.Data
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemFlavorFlags(itemID as Ptr, flavor as String) As UInt32
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardGetItemFlavorFlags lib "Carbon" (ref as Ptr, id as Ptr, type as CFStringRef, ByRef data as UInt32) as Integer
		  
		  dim d as UInt32
		  mLastError = PasteboardGetItemFlavorFlags (mRef, itemID, flavor, d)
		  
		  if mLastError = 0 then
		    return d
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemFlavors(itemID as Ptr) As String()
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardCopyItemFlavors lib "Carbon" (ref as Ptr, id as Ptr, ByRef data as Ptr) as Integer
		  
		  dim d as Ptr
		  mLastError = PasteboardCopyItemFlavors (mRef, itemID, d)
		  
		  if mLastError = 0 then
		    dim a as new CFArray (d, CFArray.hasOwnership)
		    return a.StringValues
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemIdentifier(index_1based as Integer) As Ptr
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardGetItemIdentifier lib "Carbon" (ref as Ptr, idx as Integer, ByRef data as Ptr) as Integer
		  
		  dim d as Ptr
		  mLastError = PasteboardGetItemIdentifier (mRef, index_1based, d)
		  
		  if mLastError = 0 then
		    return d
		  else
		    return Ptr(index_1based)
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  return mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PasteLocation() As CFURL
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardCopyPasteLocation lib "Carbon" (ref as Ptr, ByRef data as Ptr) as Integer
		  
		  dim d as Ptr
		  mLastError = PasteboardCopyPasteLocation (mRef, d)
		  
		  if mLastError = 0 then
		    dim url as new CFURL (d, CFData.hasOwnership)
		    return url
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PutItemFlavor(itemID as Ptr, flavor as String, data as MemoryBlock, flags as UInt32) As Boolean
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardPutItemFlavor lib "Carbon" (ref as Ptr, id as Ptr, flavor as CFStringRef, data as Ptr, flags as UInt32) as Integer
		  
		  mLastError = PasteboardPutItemFlavor (mRef, itemID, flavor, new CFData (data), flags)
		  
		  return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResolvePromises()
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardResolvePromises lib "Carbon" (ref as Ptr) as Integer
		  
		  mLastError = PasteboardResolvePromises (mRef)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetPasteLocation(url as CFURL) As Boolean
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardSetPasteLocation lib "Carbon" (ref as Ptr, url as Ptr) as Integer
		  
		  mLastError = PasteboardSetPasteLocation (mRef, url.Reference)
		  
		  return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Synchronize(ByRef modified as Boolean, ByRef isOwn as Boolean)
		  #pragma DisableBackgroundTasks
		  
		  declare function PasteboardSynchronize lib "Carbon" (ref as Ptr) as UInt32
		  
		  dim n as UInt32 = PasteboardSynchronize (mRef)
		  
		  modified = (n and 1) <> 0
		  isOwn = (n and 2) <> 0
		  
		  mLastError = 0
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  declare function PasteboardGetItemCount lib "Carbon" (ref as Ptr, ByRef n as UInt32) as Integer
			  
			  dim n as UInt32
			  mLastError = PasteboardGetItemCount (mRef, n)
			  
			  if mLastError = 0 then
			    return n
			  end if
			End Get
		#tag EndGetter
		ItemCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastError As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRef As Ptr
	#tag EndProperty


	#tag Constant, Name = kPasteboardFlavorNoFlags, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPasteboardFlavorNotSaved, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPasteboardFlavorPromised, Type = Double, Dynamic = False, Default = \"512", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPasteboardFlavorRequestOnly, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPasteboardFlavorSenderOnly, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPasteboardFlavorSenderTranslated, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPasteboardFlavorSystemTranslated, Type = Double, Dynamic = False, Default = \"256", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ItemCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
