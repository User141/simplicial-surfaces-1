#############################################################################
##
##  SimplicialSurface package
##
##  Copyright 2012-2016
##    Markus Baumeister, RWTH Aachen University
##    Alice Niemeyer, RWTH Aachen University 
##
## Licensed under the GPL 3 or later.
##
#############################################################################


##############################################################################
##
##          Methods for labelled access
##
InstallMethod( Vertices, "for a polygonal complex", [IsPolygonalComplex],
	function(complex)
		return VerticesAttributeOfPolygonalComplex( complex );
	end
);

# methods to compute number of vertices, edges, faces
InstallMethod( NumberOfVertices, "for a polygonal complex", [IsPolygonalComplex],
    function(complex)
            return Length( Vertices(complex) );
    end
);

InstallMethod( NumberOfEdges, "for a polygonal complex", [IsPolygonalComplex],
    function(complex)
            return Length( Edges(complex) );
    end
);

InstallMethod( NumberOfFaces, "for a polygonal complex", [IsPolygonalComplex],
    function(complex)
            return Length( Faces(complex) );
    end
);

##
## Inclusion in the attribute scheduler
##
__SIMPLICIAL_AddPolygonalAttribute( VerticesAttributeOfPolygonalComplex );
__SIMPLICIAL_AddPolygonalAttribute( Edges );
__SIMPLICIAL_AddPolygonalAttribute( Faces );

##
##              End of labelled access
##
##############################################################################


##############################################################################
##
##          Methods for basic access (*Of*)
##
#TODO explain internal structure of *Of*

##
## Inclusion in the attribute scheduler
##
__SIMPLICIAL_AddPolygonalAttribute( EdgesOfVertices );
__SIMPLICIAL_AddPolygonalAttribute( FacesOfVertices );
__SIMPLICIAL_AddPolygonalAttribute( VerticesOfEdges );
__SIMPLICIAL_AddPolygonalAttribute( FacesOfEdges );
__SIMPLICIAL_AddPolygonalAttribute( VerticesOfFaces );
__SIMPLICIAL_AddPolygonalAttribute( EdgesOfFaces );

##
## Connection between labelled access and *Of*-attributes (via scheduler)
##

## EdgesOfVertices
InstallMethod( Edges, 
    "for a polygonal complex with EdgesOfVertices",
    [IsPolygonalComplex and HasEdgesOfVertices],
    function(complex)
        return Union(EdgesOfVertices(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Edges", "EdgesOfVertices");

InstallMethod( VerticesAttributeOfPolygonalComplex, 
    "for a polygonal complex with EdgesOfVertices",
    [IsPolygonalComplex and HasEdgesOfVertices],
    function(complex)
        return __SIMPLICIAL_BoundEntriesOfList(EdgesOfVertices(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "VerticesAttributeOfPolygonalComplex", "EdgesOfVertices");


## FacesOfVertices
InstallMethod( Faces, "for a polygonal complex with FacesOfVertices",
    [IsPolygonalComplex and HasFacesOfVertices],
    function(complex)
        return Union(FacesOfVertices(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Faces", "FacesOfVertices");

InstallMethod( VerticesAttributeOfPolygonalComplex, 
    "for a polygonal complex with FacesOfVertices",
    [IsPolygonalComplex and HasFacesOfVertices],
    function(complex)
        return __SIMPLICIAL_BoundEntriesOfList(FacesOfVertices(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "VerticesAttributeOfPolygonalComplex", "FacesOfVertices");


## VerticesOfEdges
InstallMethod( VerticesAttributeOfPolygonalComplex, 
    "for a polygonal complex with VerticesOfEdges",
    [IsPolygonalComplex and HasVerticesOfEdges],
    function(complex)
        return Union(VerticesOfEdges(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "VerticesAttributeOfPolygonalComplex", "VerticesOfEdges");

InstallMethod( Edges, "for a polygonal complex with VerticesOfEdges",
    [IsPolygonalComplex and HasVerticesOfEdges],
    function(complex)
        return __SIMPLICIAL_BoundEntriesOfList(VerticesOfEdges(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Edges", "VerticesOfEdges");


## FacesOfEdges
InstallMethod( Faces, "for a polygonal complex with FacesOfEdges",
    [IsPolygonalComplex and HasFacesOfEdges],
    function(complex)
        return Union(FacesOfEdges(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Faces", "FacesOfEdges");

InstallMethod( Edges, "for a polygonal complex with FacesOfEdges",
    [IsPolygonalComplex and HasFacesOfEdges],
    function(complex)
        return __SIMPLICIAL_BoundEntriesOfList(FacesOfEdges(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Edges", "FacesOfEdges");


## VerticesOfFaces
InstallMethod( VerticesAttributeOfPolygonalComplex, 
    "for a polygonal complex with VerticesOfFaces",
    [IsPolygonalComplex and HasVerticesOfFaces],
    function(complex)
        return Union(VerticesOfFaces(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "VerticesAttributeOfPolygonalComplex", "VerticesOfFaces");

InstallMethod( Faces, "for a polygonal complex with VerticesOfFaces",
    [IsPolygonalComplex and HasVerticesOfFaces],
    function(complex)
        return __SIMPLICIAL_BoundEntriesOfList(VerticesOfFaces(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Faces", "VerticesOfFaces");



## EdgesOfFaces
InstallMethod( Edges, "for a polygonal complex with EdgesOfFaces",
    [IsPolygonalComplex and HasEdgesOfFaces],
    function(complex)
        return Union(EdgesOfFaces(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Edges", "EdgesOfFaces");

InstallMethod( Faces, "for a polygonal complex with EdgesOfFaces",
    [IsPolygonalComplex and HasEdgesOfFaces],
    function(complex)
        return __SIMPLICIAL_BoundEntriesOfList(EdgesOfFaces(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Faces", "EdgesOfFaces");

##
##  Implement "faster" access to *Of*-attributes by adding an argument
##

## EdgesOfVertices
InstallMethod(EdgesOfVertexNC, 
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, vertex)
        return EdgesOfVertices(complex)[vertex];
    end
);
InstallMethod(EdgesOfVertex,
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, vertex)
        __SIMPLICIAL_CheckVertex( complex, vertex, "EdgesOfVertex" );
        return EdgesOfVertexNC(complex,vertex);
    end
);

## FacesOfVertices
InstallMethod(FacesOfVertexNC, 
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, vertex)
        return FacesOfVertices(complex)[vertex];
    end
);
InstallMethod(FacesOfVertex,
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, vertex)
        __SIMPLICIAL_CheckVertex( complex, vertex, "FacesOfVertex" );
        return FacesOfVertexNC(complex,vertex);
    end
);


## VerticesOfEdges
InstallMethod(VerticesOfEdgeNC, 
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, edge)
        return VerticesOfEdges(complex)[edge];  
    end
);
InstallMethod(VerticesOfEdge,
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, edge)
        __SIMPLICIAL_CheckEdge( complex, edge, "VerticesOfEdge" );
        return VerticesOfEdgeNC(complex,edge);
    end
);


## FacesOfEdges
InstallMethod(FacesOfEdgeNC, 
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, edge)
        return FacesOfEdges(complex)[edge]; 
    end
);
InstallMethod(FacesOfEdge,
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, edge)
        __SIMPLICIAL_CheckEdge( complex, edge, "FacesOfEdge" );
        return FacesOfEdgeNC(complex,edge);
    end
);


## VerticesOfFaces
InstallMethod(VerticesOfFaceNC, 
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, face)
        return VerticesOfFaces(complex)[face];
    end
);
InstallMethod(VerticesOfFace,
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, face)
        __SIMPLICIAL_CheckFace( complex, face, "VerticesOfFace" );
        return VerticesOfFaceNC(complex,face);
    end
);


## EdgesOfFaces
InstallMethod(EdgesOfFaceNC, 
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, face)
        return EdgesOfFaces(complex)[face];    
    end
);
InstallMethod(EdgesOfFace,
    "for a polygonal complex and a positive integer",
    [IsPolygonalComplex, IsPosInt],
    function(complex, face)
        __SIMPLICIAL_CheckFace( complex, face, "EdgesOfFace" );
        return EdgesOfFaceNC(complex,face);
    end
);


##
## Methods to inverse the incidence relation.
## They transform A_Of_B to B_Of_A.
##
BindGlobal( "__SIMPLICIAL_InvertIncidence", 
    function( a_labels, a_of_b, b_labels )
        local b_of_a, a, b_set, b;

        b_of_a := [];
        for a in a_labels do
            b_set := [];
            for b in b_labels do
                if a in a_of_b[b] then
                    Add(b_set,b);
                fi;
            od;
            b_of_a[a] := Set(b_set);
        od;

        return b_of_a;
    end
);

InstallMethod( EdgesOfVertices,
    "for a polygonal complex that has VerticesOfEdges",
    [IsPolygonalComplex and HasVerticesOfEdges],
    function(complex)
        return __SIMPLICIAL_InvertIncidence( Vertices(complex),
            VerticesOfEdges(complex), Edges(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "EdgesOfVertices", "VerticesOfEdges");


InstallMethod( FacesOfVertices,
    "for a polygonal complex that has VerticesOfFaces",
    [IsPolygonalComplex and HasVerticesOfFaces],
    function(complex)
        return __SIMPLICIAL_InvertIncidence( Vertices(complex),
            VerticesOfFaces(complex), Faces(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "FacesOfVertices", "VerticesOfFaces");


InstallMethod( VerticesOfEdges,
    "for a polygonal complex that has EdgesOfVertices",
    [IsPolygonalComplex and HasEdgesOfVertices],
    function(complex)
        return __SIMPLICIAL_InvertIncidence(Edges(complex),
            EdgesOfVertices(complex), Vertices(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "VerticesOfEdges", "EdgesOfVertices");


InstallMethod( FacesOfEdges,
    "for a polygonal complex that has EdgesOfFaces",
    [IsPolygonalComplex and HasEdgesOfFaces],
    function(complex)
        return __SIMPLICIAL_InvertIncidence( Edges(complex),
            EdgesOfFaces(complex), Faces(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "FacesOfEdges", "EdgesOfFaces");


InstallMethod( VerticesOfFaces,
    "for a polygonal complex that has FacesOfVertices",
    [IsPolygonalComplex and HasFacesOfVertices],
    function(complex)
        return __SIMPLICIAL_InvertIncidence( Faces(complex),
            FacesOfVertices(complex), Vertices(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "VerticesOfFaces", "FacesOfVertices");


InstallMethod( EdgesOfFaces,
    "for a polygonal complex that has FacesOfEdges",
    [IsPolygonalComplex and HasFacesOfEdges],
    function(complex)
        return __SIMPLICIAL_InvertIncidence( Faces(complex),
            FacesOfEdges(complex), Edges(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "EdgesOfFaces", "FacesOfEdges");


##
## Methods to combine a_of_b and b_of_c to a_of_c (transitivity).
##
BindGlobal( "__SIMPLICIAL_TransitiveIncidence", 
    function( a_labels, a_of_b, b_labels, b_of_c, c_labels )
        local c, a_of_c, a_in_b, b_in_c;

        a_of_c := [];
        for c in c_labels do
            b_in_c := b_of_c[c];
            a_in_b := List( b_in_c, x -> a_of_b[x] );
            a_of_c[c] := Union(a_in_b);
        od;

        return a_of_c;
    end
);

InstallMethod( VerticesOfFaces,
    "for a polygonal complex with VerticesOfEdges and EdgesOfFaces",
    [IsPolygonalComplex and HasVerticesOfEdges and HasEdgesOfFaces],
    function(complex)
        return __SIMPLICIAL_TransitiveIncidence( Vertices(complex),
            VerticesOfEdges(complex), Edges(complex), EdgesOfFaces(complex),
            Faces(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "VerticesOfFaces", ["VerticesOfEdges", "EdgesOfFaces"]);

InstallMethod( FacesOfVertices,
    "for a polygonal complex with FacesOfEdges and EdgesOfVertices",
    [IsPolygonalComplex and HasFacesOfEdges and HasEdgesOfVertices],
    function(complex)
        return __SIMPLICIAL_TransitiveIncidence( Faces(complex),
            FacesOfEdges(complex), Edges(complex), EdgesOfVertices(complex),
            Vertices(complex));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "FacesOfVertices", ["FacesOfEdges", "EdgesOfVertices"]);



##
##          End of basic access (*Of*)
##
##############################################################################



#############################################################################
##
##          Start of specialized access
##
InstallMethod( EdgeInFaceByVerticesNC, 
    "for a polygonal complex, a face and a set of two vertices",
    [IsPolygonalComplex, IsPosInt, IsSet],
    function( complex, face, vertSet )
        local possEdges;

        possEdges := Filtered( EdgesOfFaces(complex)[face], e -> 
                VerticesOfEdges(complex)[e] = vertSet );
        if Size(possEdges) = 0 then
            return fail;
        elif Size(possEdges) > 1 then
            Error("EdgeInFaceByVertices: Internal error.");
        fi;
        return possEdges[1];
    end
);
InstallMethod( EdgeInFaceByVerticesNC,
    "for a polygonal complex, a face and a list of two vertices",
    [IsPolygonalComplex, IsPosInt, IsList],
    function( complex, face, vertList )
        return EdgeInFaceByVerticesNC(complex, face, Set(vertList));
    end
);
InstallMethod( EdgeInFaceByVertices,
    "for a polygonal complex, a face and a set of two vertices",
    [IsPolygonalComplex, IsPosInt, IsSet],
    function( complex, face, vertSet )
        __SIMPLICIAL_CheckFace(complex, face, "EdgeInFaceByVertices");
        return EdgeInFaceByVerticesNC(complex, face, vertSet);
    end
);
InstallMethod( EdgeInFaceByVertices,
    "for a polygonal complex, a face and a list of two vertices",
    [IsPolygonalComplex, IsPosInt, IsList],
    function( complex, face, vertList )
        return EdgeInFaceByVertices(complex, face, Set(vertList));
    end
);



InstallMethod( OtherEdgeOfVertexInFaceNC,
    "for a polygonal complex, a vertex, an edge and a face",
    [IsPolygonalComplex, IsPosInt, IsPosInt, IsPosInt],
    function( complex, vertex, edge, face )
        local possEdges, res;

        possEdges := EdgesOfFaces(complex)[face];
        res := Filtered( possEdges, e -> vertex in VerticesOfEdges(complex)[e] and e <> edge );
        return res[1];
    end
 );

InstallMethod( OtherEdgeOfVertexInFace,
    "for a polygonal complex, a vertex, an edge and a face",
    [IsPolygonalComplex, IsPosInt, IsPosInt, IsPosInt],
    function( complex, vertex, edge, face )
        local name;

        name := "OtherEdgeOfVertexInFace";
        __SIMPLICIAL_CheckVertex(complex, vertex, name);
        __SIMPLICIAL_CheckEdge(complex, edge, name);
        __SIMPLICIAL_CheckFace(complex, face, name);
        __SIMPLICIAL_CheckIncidenceVertexEdge(complex, vertex, edge, name);
        __SIMPLICIAL_CheckIncidenceEdgeFace(complex, edge, face, name);

        return OtherEdgeOfVertexInFaceNC(complex, vertex, edge, face);
    end
);


InstallMethod( OtherVertexOfEdgeNC,
    "for a polygonal complex, a vertex and an edge",
    [IsPolygonalComplex, IsPosInt, IsPosInt],
    function( complex, vertex, edge )
        local possVert;
        
        possVert := VerticesOfEdges(complex)[edge];
        if vertex = possVert[1] then
            return possVert[2];
        else
            return possVert[1];
        fi;
    end
);
InstallMethod( OtherVertexOfEdge,
    "for a polygonal complex, a vertex and an edge",
    [IsPolygonalComplex, IsPosInt, IsPosInt],
    function( complex, vertex, edge )
        local name;
        
        name := "OtherVertexOfEdge";
        __SIMPLICIAL_CheckEdge(complex, edge, name);
        __SIMPLICIAL_CheckIncidenceVertexEdge(complex, vertex, edge, name);
        return OtherVertexOfEdgeNC(complex, vertex, edge);
    end
);


InstallMethod( NeighbourFaceByEdgeNC,
    "for a polygonal complex, a face and an edge",
    [IsPolygonalComplex, IsPosInt, IsPosInt],
    function( complex, face, edge )
        local possFaces;
        
        possFaces := FacesOfEdges(complex)[edge];
        if Size(possFaces) <> 2 then #TODO special case for RamifiedComplexes useful?
            return fail;
        fi;

        if possFaces[1] = face then
            return possFaces[2];
        else
            return possFaces[1];
        fi;
    end
);
InstallMethod( NeighbourFaceByEdge,
    "for a polygonal complex, a face and an edge",
    [IsPolygonalComplex, IsPosInt, IsPosInt],
    function( complex, face, edge )
        local name;
        
        name := "NeighbourFaceByEdge";
        __SIMPLICIAL_CheckEdge(complex,edge, name);
        __SIMPLICIAL_CheckFace(complex, face, name);
        __SIMPLICIAL_CheckIncidenceEdgeFace(complex, edge, face, name);
        
        return NeighbourFaceByEdgeNC(complex, face, edge);
    end
);


##
##          End of specialized access
##
##############################################################################



##############################################################################
##
##          Face-induced order of vertices/edges
##
__SIMPLICIAL_AddPolygonalAttribute(PerimetersOfFaces);


# the wrappers
InstallMethod( PerimeterOfFaceNC, 
    "for a polygonal complex and a face (positive integer)",
    [IsPolygonalComplex, IsPosInt],
    function(complex, face)
        return PerimeterOfFaceNC(complex, face);
    end
);
InstallMethod( PerimeterOfFace,
    "for a polygonal complex and a face (positive integer)",
    [IsPolygonalComplex, IsPosInt],
    function(complex, face)
        __SIMPLICIAL_CheckFace(complex, face, "PerimeterOfFace");
        return PerimeterOfFaceNC(complex, face);
    end
);


# main computation method
InstallMethod( PerimetersOfFaces, "for a polygonal complex", 
    [IsPolygonalComplex],
    function(complex)
        local paths, f, localVertices, startVert, adEdges, adVertices,
            i, localPath, len;

        paths := [];
        for f in Faces(complex) do
            localVertices := VerticesOfFaces(complex)[f];
            startVert := Minimum(localVertices);
            adEdges := Intersection( EdgesOfFaces(complex)[f],
                        EdgesOfVertices(complex)[startVert]);
            adVertices := List(adEdges, e ->
                    OtherVertexOfEdgeNC(complex,startVert,e));
            Assert(1, Size(adVertices)=2);
            Assert(1, adEdges[1]<>adEdges[2]);
            
            if adVertices[1] < adVertices[2] then
                localPath := [ startVert, adEdges[1], adVertices[1] ];
            elif adVertices[1] > adVertices[2] then
                localPath := [ startVert, adEdges[2], adVertices[2] ];
            else
                if adEdges[1] < adEdges[2] then
                    localPath := [ startVert, adEdges[1], adVertices[1] ];
                else
                    localPath := [ startVert, adEdges[2], adVertices[2] ];
                fi;
            fi;

            for i in [2..Size(localVertices)] do # How long will the path be?
                len := Length(localPath);
                Add( localPath, OtherEdgeOfVertexInFaceNC(complex,
                        localPath[len],localPath[len-1],f) );
                Add( localPath, OtherVertexOfEdgeNC(complex,
                        localPath[len],localPath[len+1]) );
            od;
            Assert(1, localPath[1] = localPath[Length(localPath)]);
            paths[f] := VertexEdgePathNC(complex, localPath);
        od;

        return paths;
    end
);

AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "PerimetersOfFaces", ["Faces", "VerticesOfFaces", "EdgesOfFaces", 
                    "VerticesOfEdges", "EdgesOfVertices"]);


# inferences from the vertexEdgePath
InstallMethod( VerticesOfFaces, 
    "for a polygonal complex with PerimetersOfFaces",
    [IsPolygonalComplex and HasPerimetersOfFaces],
    function(complex)
        return List( PerimetersOfFaces(complex), p -> Set(VerticesAsList(p)) );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "VerticesOfFaces", ["PerimetersOfFaces"] );


InstallMethod( EdgesOfFaces, 
    "for a polygonal complex with PerimetersOfFaces",
    [IsPolygonalComplex and HasPerimetersOfFaces],
    function(complex)
        return List( PerimetersOfFaces(complex), p -> Set(EdgesAsList(p)) );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "EdgesOfFaces", ["PerimetersOfFaces"] );


InstallMethod( Faces,
    "for a polygonal complex that has PerimetersOfFaces",
    [IsPolygonalComplex and HasPerimetersOfFaces],
    function(complex)
        return __SIMPLICIAL_BoundEntriesOfList( PerimetersOfFaces(complex) );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Faces", "PerimetersOfFaces");



##
##	To perform the conversion between VerticesAsList and EdgesAsList we
##	implement a global function (as both conversions are identical from
##	the perspective of incidence geometry). We start with
##		a list of lists (in terms of elements A)
##		an index for the list (in our case that will be the faces)
##		a conversion of A in terms of B (the elements A are indices of this conversion)
##		a list of sets of all elements of B that are possible (for a given face)
##
BindGlobal( "__SIMPLICIAL_ConversionListsVerticesEdges", 
    function( listOfLists, listIndex, conversion, possibleNewElements )
	local newListOfLists, i, oldList, newList, firstEl, secondEl, 
            intersection, j, currentEl, nextEl, min, pos;

        if listOfLists = fail then
            return fail;
        fi;

	newListOfLists := [];
	# Iterate over the list index
	for i in listIndex do
		# We want to convert the elements of listOfLists (the 'old lists')
		# into the elements of newListOfLists (the 'new lists')
		oldList := listOfLists[i];
		newList := [];

		# Intersect first and last element of the oldList to obtain the first
		# element of the newList
		firstEl := Set( conversion[ oldList[1] ] );
		secondEl := Set( conversion[ oldList[ Length(oldList) ] ] );
		intersection := Intersection( firstEl, secondEl, 
                        possibleNewElements[i] );
                Assert( 1, Length(intersection)=1 );
		newList[1] := intersection[1];

		# Now we continue for all other elements
		for j in [2..Length(oldList)] do
			currentEl := Set( conversion[ oldList[j-1] ] );
			nextEl := Set( conversion[ oldList[j] ] );
			intersection := Intersection( currentEl, nextEl, 
					        possibleNewElements[i] );
                        Assert(1, Length(intersection)=1);
			newList[j] := intersection[1];
		od;

                # Normalise the new list
                min := Minimum( newList );
                pos := Position( newList, min );
                newList := Concatenation( newList{[pos..Length(newList)]}, newList{[1..pos-1]} );

		newListOfLists[i] := newList;
	od;

	return newListOfLists;
    end
);


#
# conversion between permutation and list representation
# 

##
##	Given a list of permutations (that have to be cycles) and an index set,
##	this function returns a list of lists such that these lists represent the
##	cycle representation of the permutation. For example the permutation (1,2,3)
##	may be represented by the lists [1,2,3], [2,3,1] or [3,1,2]. To define this
##	representation uniquely we stipulate that the first entry in the list
##	representation is the smallest entry of the list. In the above example,
##	the list [1,2,3] would be the so defined representation. Fixed points will
##	be ignored.
##
BindGlobal( "__SIMPLICIAL_TranslateCyclesIntoLists", 
    function( listOfPerms )
	local listOfLists, Shift;

        if listOfPerms = fail then
            return fail;
        fi;

        Shift := function( perm )
            local points, listRep, j;

            points := MovedPoints(perm);

            # Since points is a set, the first element is the smallest
            listRep := [ points[1] ];
            for j in [1..Length(points)-1] do
                Append(listRep, [ listRep[j]^perm ]);
            od;

            return listRep;
        end;

        return List( listOfPerms, Shift );
    end
);

##
##	Given a list of lists, this function returns a list of
##	permutations such that each permutation is defined by the list (like it
##	was described for the function above).
##
BindGlobal( "__SIMPLICIAL_TranslateListsIntoCycles", function( listOfLists )
        if listOfLists = fail then
            return fail;
        fi;

        return List( listOfLists, __SIMPLICIAL_ListToCycle ); # see dual_path.gi for implementation
    end
);

##
##          End of face-induced order
##
##############################################################################




##############################################################################
##
##      Edge-Face-Paths around vertices
##
__SIMPLICIAL_AddPolygonalAttribute(EdgeFacePathPartitionsOfVertices);
__SIMPLICIAL_AddPolygonalAttribute(EdgeFacePathsOfVertices);

##
## Implement the immediate methods for inferences about the complex
##
InstallImmediateMethod( IsPolygonalSurface, 
    "for a polygonal complex that has EdgeFacePathsOfVertices",
    IsPolygonalComplex and HasEdgeFacePathsOfVertices, 0,
    function(complex)
        return not fail in EdgeFacePathsOfVertices(complex);
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "IsPolygonalSurface", "EdgeFacePathsOfVertices");
InstallImmediateMethod( IsRamifiedPolygonalSurface,
    "for a polygonal complex that has EdgeFacePathPartitionsOfVertices",
    IsPolygonalComplex and HasEdgeFacePathPartitionsOfVertices, 0,
    function(complex)
        return not fail in EdgeFacePathPartitionsOfVertices(complex);
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "IsRamifiedPolygonalSurface", "EdgeFacePathPartitionsOfVertices");

##
## We will implement the connections between singular paths and partitions
## first. Afterward we will connect the partitions with everything else.
##

InstallMethod( EdgeFacePathsOfVertices, 
    "for a polygonal surface that has EdgeFacePathPartitionsOfVertices",
    [IsPolygonalSurface and HasEdgeFacePathPartitionsOfVertices],
    function( surface )
        return List( EdgeFacePathPartitionsOfVertices(surface), p -> p[1] );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "EdgeFacePathsOfVertices", 
    ["IsPolygonalSurface", "EdgeFacePathPartitionsOfVertices"]);

InstallMethod( EdgeFacePathPartitionsOfVertices,
    "for a ramified polygonal surface that has EdgeFacePathsOfVertices",
    [IsRamifiedPolygonalSurface and HasEdgeFacePathsOfVertices],
    function( ramSurf )
        return List( EdgeFacePathsOfVertices(ramSurf), p -> [p] );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "EdgeFacePathPartitionsOfVertices", 
    ["EdgeFacePathsOfVertices", "IsRamifiedPolygonalSurface"] );


## Methods for one single vertex
InstallMethod( EdgeFacePathOfVertexNC, "for a polygonal complex and a vertex",
    [IsPolygonalComplex, IsPosInt],
    function( surface, vertex )
        return EdgeFacePathsOfVertices(surface)[vertex];
    end
);
InstallMethod( EdgeFacePathOfVertex, "for a polygonal complex and a vertex",
    [IsPolygonalComplex, IsPosInt],
    function( surface, vertex )
        __SIMPLICIAL_CheckVertex(surface,vertex, "EdgeFacePathOfVertex");
        return EdgeFacePathOfVertexNC(surface, vertex);
    end
);

InstallMethod( EdgeFacePathPartitionOfVertexNC,
    "for a ramified polygonal complex and a vertex",
    [IsPolygonalComplex, IsPosInt],
    function( ramSurf, vertex )
        return EdgeFacePathPartitionsOfVertices(ramSurf)[vertex];
    end
);
InstallMethod( EdgeFacePathPartitionOfVertex,
    "for a ramified polygonal complex and a vertex",
    [IsPolygonalComplex, IsPosInt],
    function( ramSurf, vertex )
        __SIMPLICIAL_CheckVertex(ramSurf, vertex, "EdgeFacePathPartitionOfVertex");
        return EdgeFacePathPartitionOfVertexNC(ramSurf, vertex);
    end
);

##
## Implications from EdgeFacePathPartitionsOfVertices (only to *Of*, since 
## implications to vertices, edges and faces follow from that)
##
BindGlobal( "__SIMPLICIAL_EvenEntries", function(list)
    local len, ind;

    len := Size(list);
    if IsEvenInt(len) then
        ind := [1..len/2];
    else
        ind := [1..(len-1)/2];
    fi;
    return Set( List( ind, i->list[2*i] ) );
end);
BindGlobal( "__SIMPLICIAL_OddEntries", function(list)
    local len, ind;
    
    len := Size(list);
    if IsEvenInt(len) then
        ind := [1..len/2];
    else
        ind := [1..(len+1)/2];
    fi;
    return Set( List( ind, i->list[2*i-1] ) );
end);

InstallMethod( EdgesOfVertices, 
    "for a ramified polygonal surface that has EdgeFacePathPartitionsOfVertices", 
    [IsRamifiedPolygonalSurface and HasEdgeFacePathPartitionsOfVertices],
    function(complex)
        return List( EdgeFacePathPartitionsOfVertices(complex), part ->
            Union( List( part, __SIMPLICIAL_OddEntries ) ));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "EdgesOfVertices", 
    ["IsRamifiedPolygonalSurface", "EdgeFacePathPartitionsOfVertices"]);

InstallMethod( FacesOfVertices,
    "for a ramified polygonal surface that has EdgeFacePathPartitionsOfVertices",
    [IsRamifiedPolygonalSurface and HasEdgeFacePathPartitionsOfVertices],
    function(complex)
        return List( EdgeFacePathPartitionsOfVertices(complex), part ->
            Union( List( part, __SIMPLICIAL_EvenEntries ) ));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "FacesOfVertices", 
    ["IsRamifiedPolygonalSurface", "EdgeFacePathPartitionsOfVertices"]);

InstallMethod( FacesOfEdges,
    "for a ramified polygonal surface that has EdgeFacePathPartitionsOfVertices and VerticesAttributeOfPolygonalComplex",
    [IsRamifiedPolygonalSurface and HasEdgeFacePathPartitionsOfVertices and HasVerticesAttributeOfPolygonalComplex],
    function(complex)
        local facesOfEdges, parts, v, p, even, ind, i, edge, incFaces;

        parts := EdgeFacePathPartitionsOfVertices(complex);

        facesOfEdges := [];
        for v in Vertices(complex) do
            for p in parts[v] do
                even := IsEvenInt(Size(p));
                if even then
                    ind := [1..Size(p)/2];
                else
                    ind := [1..(Size(p)+1)/2];
                fi;

                for i in ind do
                    edge := p[2*i-1];
                    if IsBound(facesOfEdges[edge]) then
                        # Since the complex is ramified, the incident faces should be the same
                        continue;
                    fi;

                    if i = 1 and even then
                        incFaces := Set([ p[2], p[Size(p)] ]);
                    elif i = 1 then
                        incFaces := [p[2]];
                    elif not even and i = Size(ind) then
                        incFaces := [p[Size(p)-1]];
                    else
                        incFaces := Set( [p[2*i-2],p[2*i]] );
                    fi;
                    facesOfEdges[edge] := incFaces;
                od;
            od;
        od;

        return facesOfEdges;
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, "FacesOfEdges", 
    ["EdgeFacePathPartitionsOfVertices", "VerticesAttributeOfPolygonalComplex", "IsRamifiedPolygonalSurface"]);


InstallMethod( EdgeFacePathPartitionsOfVertices, 
    "for a polygonal complex that has VerticesAttributeOfPolygonalComplex, EdgesOfVertices, EdgesOfFaces, FacesOfEdges and VerticesOfEdges",
    [IsPolygonalComplex and HasVerticesAttributeOfPolygonalComplex and 
        HasEdgesOfVertices and HasEdgesOfFaces and HasFacesOfEdges and 
        HasVerticesOfEdges],
    function(ramSurf)
        local faceEdgePathPart, vertex, incidentEdges, paths,
            edgeStart, possFaces, rightFinished, leftFinished, backFace, path,
            nextEdge, nextFace;

        faceEdgePathPart := [];

        for vertex in Vertices(ramSurf) do
            incidentEdges := EdgesOfVertices(ramSurf)[vertex];
            paths := [];

            while not IsEmpty( incidentEdges ) do
                # If the path is not closed, we can't hope to find the correct 
                # start immediately. If the path is closed, the correct start 
                # is the smallest edge.
                edgeStart := incidentEdges[1]; # minimal since we have a set
                incidentEdges := incidentEdges{[2..Length(incidentEdges)]};
                possFaces := FacesOfEdges(ramSurf)[edgeStart];

                # We use two bools to check if we are done
                rightFinished := false;
                leftFinished := false;
                if Length(possFaces) > 2 then
                    # break completely - no edge-face-path partition exists
                    paths := fail;
                    break;
                elif Length(possFaces) = 1 then
                    # very rare special case, where our first pick for a 
                    # non-closed path was lucky
                    leftFinished := true;
                    backFace := fail;
                else
                    # In the hope for a closed path, we continue with the 
                    # smaller face (and store the other one)
                    backFace := possFaces[2];
                fi;
                path := [edgeStart, possFaces[1]];


                # As we may have to traverse both directions (non-closed case)
                # and those traversals are completely equal we use one loop
                # for both
                while not rightFinished or not leftFinished do
                    # Try to extend the path beyond the last face
                    nextEdge := OtherEdgeOfVertexInFaceNC(ramSurf, vertex, 
                            path[Length(path)-1], path[Length(path)]); 
                            # calls EdgesOfFaces and VerticesOfEdges
                    # We only need to care for this set (the other is ignored)
                    incidentEdges := Difference( incidentEdges, [nextEdge] );

                    nextFace := NeighbourFaceByEdgeNC(ramSurf, 
                        path[Length(path)], nextEdge); # calls FacesOfEdges
                    if nextFace = fail then
                        # check if we had a branch
                        if IsRamifiedEdge(ramSurf, nextEdge) then
                            path := fail;
                            break;
                        fi;
                        # we found an end
                        Add(path, nextEdge);
                        if leftFinished then
                            # We have finished right, but left is already 
                            # finished - we were lucky!
                            rightFinished := true;
                        elif rightFinished then
                            # Now we have finished both sides
                            if path[Length(path)] < path[1] then
                                path := Reversed(path);
                            fi;
                            leftFinished := true;
                        else
                            # We were unlucky - now we have to extend the path
                            # to the left
                            rightFinished := true;
                            path := Reversed(path);
                            Add(path, backFace);
                        fi;
                        continue;
                    fi;

                    # Otherwise we continue
                    Append(path, [nextEdge, nextFace]);
                    if nextFace = backFace then
                        # we have closed the path
                        leftFinished := true;
                        rightFinished := true;
                    fi;
                od;

                # if one of the paths breaks down, there is no partition
                if path = fail then
                    paths := fail;
                    break;
                fi;
                Add(paths, path);
            od;

            faceEdgePathPart[vertex] := paths;
        od;

        return faceEdgePathPart;
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "EdgeFacePathPartitionsOfVertices", 
    ["VerticesAttributeOfPolygonalComplex", "EdgesOfVertices", "EdgesOfFaces", 
        "FacesOfEdges", "VerticesOfEdges"]);
##
##          End of edge-face-paths
##
##############################################################################
