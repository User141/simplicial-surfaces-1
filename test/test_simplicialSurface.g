
#TODO test names of simplicial surfaces

##
##	Test the general consistency of a simplicial surface.
##	
TestSimplicialSurfaceConsistency := function( surface, messageSurfaceOrigin )
	local i, degrees, graph, name, refElements, testElements;

	if not IsSimplicialSurface( surface ) then
		Print( messageSurfaceOrigin );
		Print( " is not a simplicial surface.\n");
	fi;


	# Test the number of vertices
	if NrOfVertices(surface) <> Length(Vertices(surface)) then
		Print( messageSurfaceOrigin );
		Print( ": Vertices and number of vertices don't match.\n");
	fi;

	# Test the number of edges
	if NrOfEdges(surface) <> Length(Edges(surface)) then
		Print( messageSurfaceOrigin );
		Print( ": Edges and number of edges don't match.\n");
	fi;

	# Test the number of faces
	if NrOfFaces(surface) <> Length(Faces(surface)) then
		Print( messageSurfaceOrigin );
		Print( ": Faces and number of faces don't match.\n");
	fi;

	# Test VerticesByEdges
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


	# Test Euler-Characteristic
	if NrOfVertices(surface) - NrOfEdges(surface) + NrOfFaces(surface) <> EulerCharacteristic(surface) then
		Print( messageSurfaceOrigin );
		Print( " has incorrect Euler-characteristic.\n");
	fi;


	# Test sorted degrees
	degrees := Compacted( UnsortedDegrees(surface) );
	Sort(degrees);
	if degrees <> SortedDegrees(surface) then
		Print( messageSurfaceOrigin );
		Print( ": Sorted and unsorted degrees do not match.\n");
	fi;



	# Test local orientation
	if LocalOrientation(surface) <> LocalOrientationByVerticesAsPerm(surface) then
		Print( messageSurfaceOrigin );
		Print( " has an inconsistent default local orientation.\n");
	fi;

	for i in Faces(surface) do
		refElements := FacesByVertices(surface)[i];
		testElements := LocalOrientationByVerticesAsPerm(surface)[i];
		if refElements <> MovedPoints( testElements ) then
			Print( messageSurfaceOrigin );
			Print( " has an inconsistent local orientation at face " );
			Print( i );
			Print( " since the vertices are " );
			Print( refElements );
			Print( " but the permutation is " );
			Print( testElements );
			Print( ".\n" );
		fi;
	od;

	for i in Faces(surface) do
		refElements := FacesByVertices(surface)[i];
		testElements := LocalOrientationByVerticesAsList(surface)[i];
		if refElements <> Set( testElements ) then
			Print( messageSurfaceOrigin );
			Print( " has an inconsistent local orientation at face " );
			Print( i );
			Print( " since the vertices are " );
			Print( refElements );
			Print( " but the given list is " );
			Print( testElements );
			Print( ".\n" );
		fi;
	od;

	for i in Faces(surface) do
		refElements := FacesByEdges(surface)[i];
		testElements := LocalOrientationByEdgesAsPerm(surface)[i];
		if refElements <> MovedPoints( testElements ) then
			Print( messageSurfaceOrigin );
			Print( " has an inconsistent local orientation at face " );
			Print( i );
			Print( " since the edges are " );
			Print( refElements );
			Print( " but the permutation is " );
			Print( testElements );
			Print( ".\n" );
		fi;
	od;

	for i in Faces(surface) do
		refElements := FacesByEdges(surface)[i];
		testElements := LocalOrientationByEdgesAsList(surface)[i];
		if refElements <> Set( testElements ) then
			Print( messageSurfaceOrigin );
			Print( " has an inconsistent local orientation at face " );
			Print( i );
			Print( " since the edges are " );
			Print( refElements );
			Print( " but the given list is " );
			Print( testElements );
			Print( ".\n" );
		fi;
	od;


	# Test names of faces
	for i in Faces(surface) do
		if NamesOfFaces(surface)[i] <> NamesOfFace(surface, i) then
			Print( messageSurfaceOrigin );
			Print( " has inconsistent face name for face " );
			Print( i );
			Print( ".\n" );
		fi;
		if NamesOfFace(surface,i) <> NamesOfFaceNC(surface,i) then
			Print( messageSurfaceOrigin );
			Print( " has inconsistent NC-face name for face " );
			Print( i );
			Print( ".\n" );
		fi;
		for name in NamesOfFace(surface,i) do
			if FaceByName(surface,name) <> i then
				Print( messageSurfaceOrigin );
				Print( " can't find face " );
				Print( i );
				Print( " with its name " );
				Print( name );
				Print( ".\n" );
			fi;
		od;
	od;
	if IsFaceNamesDefault(surface) then
		for i in Faces(surface) do
			if [i,-i] <> NamesOfFaces(surface)[i] then
				Print( messageSurfaceOrigin );
				Print( " does not respect the default face naming convention for face ");
				Print( i );
				Print( " and gives their names as " );
				Print( NamesOfFaces(surface)[i] );
				Print( ".\n" );
			fi;
		od;
	fi;


	# Check incidence graph
	graph := ShallowCopy( IncidenceGraph(surface) );
	if not IsGraph(graph) then
		Print( messageSurfaceOrigin );
		Print( ": Incidence graph is not a graph.\n");
	fi;
	if OrderGraph(graph) <> NrOfVertices(surface)+NrOfEdges(surface)+NrOfFaces(surface) then
		Print( messageSurfaceOrigin );
		Print( ": Number of vertices in incidence graph is wrong.\n");
	fi;
	if IsLoopy(graph) then
		Print( messageSurfaceOrigin );
		Print( ": Incidence graph should not be loopy.\n");
	fi;
	if not IsSimpleGraph(graph) then
		Print( messageSurfaceOrigin );
		Print( ": Incidence graph is not simple.\n");
	fi;
	if IsConnectedGraph(graph) <> IsConnected(surface) then
		Print( messageSurfaceOrigin );
		Print( ": Incidence graph is not connected.\n");
	fi;
	if not IsBipartite(graph) then
		Print( messageSurfaceOrigin );
		Print( ": Incidence graph is not bipartite.\n");
	fi;

end;



##
##	Test attributes of simplicial surfaces
##	vertexNr	number of vertices
##	edgeNr		number of edges
##	faceNr		number of faces
##	isActualSurface		is the simplicial surface an actual surface?
##	isTriangleSurface	is every face of the simplicial surface a triangle?
##	isClosedSurface		is the simplicial surface closed?
##	isOrientable		is the simplicial surface orientable?
##	isConnected			is the simplicial surface connected?
##	sortDeg		the sorted degrees (vertexByFaces)
##	vertexSym	the vertex symbol (vertexByEdges)
##	anomalyClassCount		the number of anomaly classes
##	isSnippable			does the surface get smaller if we snipp of ears?
##
TestSimplicialSurfaceAttributes := function(surface, messageSurfaceOrigin, 
	vertexNr, edgeNr, faceNr, isActualSurface, isTriangleSurface, 
	isClosedSurface, isOrientable, 
	isConnected, sortDeg, vertexSym, anomalyClassCount, isSnippable)

	local conCom, euler;

	TestSimplicialSurfaceConsistency( surface, messageSurfaceOrigin );

	if NrOfVertices(surface) <> vertexNr then
		Print( messageSurfaceOrigin );
		Print( " does not have " );
		Print( vertexNr );
		Print( " vertices.\n");
	fi;
	if NrOfEdges(surface) <> edgeNr then
		Print( messageSurfaceOrigin );
		Print( " does not have " );
		Print( edgeNr );
		Print( " edges.\n");
	fi;
	if NrOfFaces(surface) <> faceNr then
		Print( messageSurfaceOrigin );
		Print( " does not have " );
		Print( faceNr );
		Print( " faces.\n");
	fi;
	euler := vertexNr - edgeNr + faceNr;
	if EulerCharacteristic(surface) <> euler then
		Print( messageSurfaceOrigin );
		Print( " does not have Euler-Characteristic " );
		Print( euler );
		Print( ".\n");
	fi;


	# actual surface check
	if IsActualSurface( surface ) <> isActualSurface then
		Print( messageSurfaceOrigin );
		if isActualSurface then
			Print( " must be an actual surface.\n" );
		else
			Print( " must not be an actual surface.\n" );
		fi;
	fi;

	# triangle surface check
	if IsTriangleSurface( surface ) <> isTriangleSurface then
		Print( messageSurfaceOrigin );
		if isTriangleSurface then
			Print( " must only consist of triangles.\n" );
		else
			Print( " must not only consist of triangles.\n" );
		fi;
	fi;

	# closed check (only makes sense if it is an actual surface)
	if IsActualSurface(surface) and IsClosedSurface( surface ) <> isClosedSurface then
		Print( messageSurfaceOrigin );
		if isClosedSurface then
			Print( " must be a closed surface.\n");
		else
			Print( " must not be closed.\n");
		fi;
	fi;

	# orientable check (only makes sense if it is an actual surface)
	if IsActualSurface(surface) and IsOrientable( surface ) <> isOrientable then
		Print( messageSurfaceOrigin );
		if isOrientable then
			Print( " must be orientable.\n");
		else
			Print( " must not be orientable.\n");
		fi;
	fi;

	# connected check
	if IsConnected( surface ) <> isConnected then
		Print( messageSurfaceOrigin );
		if isConnected then
			Print( " must be connected.\n");
		else
			Print( " must not be connected.\n");
		fi;
	fi;
	# Check connected components in the most simple case
	if isConnected then
		# TODO also test for different orders of function calls
		conCom := ConnectedComponentsAttributeOfSimplicialSurface( surface );
		if Length(conCom) <> 1 then
			Print( messageSurfaceOrigin );
			Print( " must have exactly one connected component.\n" );
		fi;
		if conCom[1] <> surface then
			Print( messageSurfaceOrigin );
			Print( " should equal its one connected component.\n");
		fi;
	fi;

	# check sorted degrees
	if SortedDegrees(surface) <> sortDeg then
		Print( messageSurfaceOrigin );
		Print( " does not have degrees " );
		Print( sortDeg );
		Print( ".\n");
	fi;

	# check vertex symbol
	if VertexSymbol(surface) <> vertexSym then
		Print( messageSurfaceOrigin );
		Print( " does not have the vertex symbol " );
		Print( vertexSym );
		Print( ".\n");
	fi;

	# check anomaly classes
	if Length( FaceAnomalyClasses(surface) ) <> anomalyClassCount then
		Print( messageSurfaceOrigin );
		Print( " should have exactly " );
		Print( anomalyClassCount );
		Print( " face anomaly class(es).\n");
	fi;

	if isSnippable then
		if surface = SnippOffEars(surface) then
			Print( messageSurfaceOrigin );
			Print( " should be changed by removal of ears.\n");
		fi;
	else
		if surface <> SnippOffEars(surface) then
			Print( messageSurfaceOrigin );
			Print( " should not be changed by removal of ears.\n");
		fi;
	fi;
end;



##
## This method supports the definition of a consistent colouring.
##
AllEdgesOfSameType := function( n, type )
	return List( [1,2,3], i -> List( [1..n], j -> type ) );
end;


##
##	Test the general consistency of a wild simplicial surface.
##	
TestWildSimplicialSurfaceConsistency := function( surface, messageSurfaceOrigin )
	# Since a wild simplicial surface also has to be a simplicial surface:
	TestSimplicialSurfaceConsistency( surface, messageSurfaceOrigin );

	if not IsWildSimplicialSurface( surface ) then
		Print( messageSurfaceOrigin );
		Print( " is not a wild simplicial surface.\n");
	fi;



	# Test the group that is generated by the generators
	if GroupOfWildSimplicialSurface(surface) <> Group( Generators( surface ) ) then
		Print( messageSurfaceOrigin );
		Print( ": Generated group and generators don't match.\n");
	fi;





	#TODO other tests.
end;
