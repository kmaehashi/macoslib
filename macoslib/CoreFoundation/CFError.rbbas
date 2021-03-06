#tag Class
Class CFError
Inherits CFType
	#tag Event
		Function ClassID() As UInt32
		  return CFError.ClassID
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		 Shared Function ClassID() As UInt32
		  #if targetMacOS
		    declare function CFErrorGetTypeID lib CarbonLib () as UInt32
		    
		    return CFErrorGetTypeID
		  #endif
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetMacOS
			    soft declare function CFErrorGetCode lib CarbonLib (err as Ptr) as Integer
			    
			    if (self <> nil) then
			      return CFErrorGetCode(self)
			    else
			      return 0
			    end if
			  #endif
			End Get
		#tag EndGetter
		Code As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetMacOS
			    soft declare function CFErrorCopyDescription lib CarbonLib (err as Ptr) as CFStringRef
			    
			    if (self <> nil) then
			      return CFErrorCopyDescription(self)
			    else
			      return ""
			    end if
			  #endif
			End Get
		#tag EndGetter
		Description As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetMacOS
			    soft declare function CFErrorGetDomain lib CarbonLib (err as Ptr) as Ptr
			    
			    if (self <> nil) then
			      return RetainedStringValue(CFErrorGetDomain(self))
			    else
			      return ""
			    end if
			  #endif
			End Get
		#tag EndGetter
		Domain As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Code"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="CFType"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Domain"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
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
