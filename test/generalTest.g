# This method supports the definition of a consistent colouring.
AllEdgesOfSameType := function( n, type )
	return List( [1,2,3], i -> List( [1..n], j -> type ) );
end;


##
##	Test the general consistency of a simplicial surface.
##	
TestSimplicialSurfaceConsistency( surface, messageSurfaceOrigin )
	local i;

	if not IsSimplicialSurface( surface ) then
		Print( messageSurfaceOrigin );
		Print( " is not a simplicial surface.\n");
	fi;

	# Test the vertices
	if Vertices(surface) <> VerticesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent vertices.\n");
	fi;

	# Test the edges
	if Edges(surface) <> EdgesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent edges.\n");
	fi;

	# Test the faces
	if Faces(surface) <> FacesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent faces.\n");
	fi;

	# Test the number of vertices
	if NrOfVertices(surface) <> NrOfVerticesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent number of vertices.\n");
	fi;
	if NrOfVertices(surface) <> Length(Vertices(surface)) then
		Print( messageSurfaceOrigin );
		Print( ": Vertices and number of vertices don't match.\n");
	fi;

	# Test the number of edges
	if NrOfEdges(surface) <> NrOfEdgesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent number of edges.\n");
	fi;
	if NrOfEdges(surface) <> Length(Edges(surface)) then
		Print( messageSurfaceOrigin );
		Print( ": Edges and number of edges don't match.\n");
	fi;

	# Test the number of faces
	if NrOfFaces(surface) <> NrOfFacesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent number of faces.\n");
	fi;
	if NrOfFaces(surface) <> Length(Faces(surface)) then
		Print( messageSurfaceOrigin );
		Print( ": Faces and number of faces don't match.\n");
	fi;

	# Test VerticesByEdges
	if VerticesByEdges(surface) <> VerticesByEdgesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent VerticesByEdges.\n");
	fi;
	for i in [1..Length(VerticesByEdges(surface))] do
		if i in Vertices(surface) then
			if not IsBound( VerticesByEdges(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": VerticesByEdges should have an entry at " );
				Print( i );
				Print( ".\n");
			elif not IsSubset( Edges(surface), VerticesByEdges(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": Entry " );
				Print( i );
				Print( " of VerticesByEdges should be a set of edges.\n");
			fi;
		else
			if IsBound( VerticesByEdges(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": VerticesByEdges should not have an entry at " );
				Print( i );
				Print( ".\n");
			fi;
		fi;
	od;

	# Test VerticesByFaces
	if VerticesByFaces(surface) <> VerticesByFacesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent VerticesByFaces.\n");
	fi;
	for i in [1..Length(VerticesByFaces(surface))] do
		if i in Vertices(surface) then
			if not IsBound( VerticesByFaces(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": VerticesByFaces should have an entry at " );
				Print( i );
				Print( ".\n");
			elif not IsSubset( Faces(surface), VerticesByFaces(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": Entry " );
				Print( i );
				Print( " of VerticesByFaces should be a set of faces.\n");
			fi;
		else
			if IsBound( VerticesByFaces(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": VerticesByFaces should not have an entry at " );
				Print( i );
				Print( ".\n");
			fi;
		fi;
	od;

	# Test EdgesByVertices
	if EdgesByVertices(surface) <> EdgesByVerticesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent EdgesByVertices.\n");
	fi;
	for i in [1..Length(EdgesByVertices(surface))] do
		if i in Edges(surface) then
			if not IsBound( EdgesByVertices(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": EdgesByVertices should have an entry at " );
				Print( i );
				Print( ".\n");
			elif not IsSubset( Vertices(surface), EdgesByVertices(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": Entry " );
				Print( i );
				Print( " of EdgesByVertices should be a set of vertices.\n");
			fi;
		else
			if IsBound( EdgesByVertices(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": EdgesByVertices should not have an entry at " );
				Print( i );
				Print( ".\n");
			fi;
		fi;
	od;

	# Test EdgesByFaces
	if EdgesByFaces(surface) <> EdgesByFacesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent EdgesByFaces.\n");
	fi;
	for i in [1..Length(EdgesByFaces(surface))] do
		if i in Edges(surface) then
			if not IsBound( EdgesByFaces(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": EdgesByFaces should have an entry at " );
				Print( i );
				Print( ".\n");
			elif not IsSubset( Faces(surface), EdgesByFaces(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": Entry " );
				Print( i );
				Print( " of EdgesByFaces should be a set of faces.\n");
			fi;
		else
			if IsBound( EdgesByFaces(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": EdgesByFaces should not have an entry at " );
				Print( i );
				Print( ".\n");
			fi;
		fi;
	od;

	# Test FacesByVertices
	if FacesByVertices(surface) <> FacesByVerticesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent FacesByVertices.\n");
	fi;
	for i in [1..Length(FacesByVertices(surface))] do
		if i in Faces(surface) then
			if not IsBound( FacesByVertices(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": FacesByVertices should have an entry at " );
				Print( i );
				Print( ".\n");
			elif not IsSubset( Vertices(surface), FacesByVertices(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": Entry " );
				Print( i );
				Print( " of FacesByVertices should be a set of vertices.\n");
			fi;
		else
			if IsBound( FacesByVertices(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": FacesByVertices should not have an entry at " );
				Print( i );
				Print( ".\n");
			fi;
		fi;
	od;

	# Test FacesByEdges
	if FacesByEdges(surface) <> FacesByEdgesAttributeOfSimplicialSurface(surface) then
		Print( messageSurfaceOrigin );
		Print( " has inconsistent FacesByEdges.\n");
	fi;
	for i in [1..Length(FacesByEdges(surface))] do
		if i in Faces(surface) then
			if not IsBound( FacesByEdges(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": FacesByEdges should have an entry at " );
				Print( i );
				Print( ".\n");
			elif not IsSubset( Edges(surface), FacesByEdges(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": Entry " );
				Print( i );
				Print( " of FacesByEdges should be a set of edges.\n");
			fi;
		else
			if IsBound( FacesByEdges(surface)[i] ) then
				Print( messageSurfaceOrigin );
				Print( ": FacesByEdges should not have an entry at " );
				Print( i );
				Print( ".\n");
			fi;
		fi;
	od;


	



end;
