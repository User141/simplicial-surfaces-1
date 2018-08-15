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

# methods to compute number of vertices, edges, faces
InstallMethod( NumberOfVertices, "for a polygonal complex", [IsVEFComplex],
    function(complex)
            return Length( VerticesAttributeOfVEFComplex(complex) );
    end
);

InstallMethod( NumberOfEdges, "for a polygonal complex", [IsVEFComplex],
    function(complex)
            return Length( Edges(complex) );
    end
);

InstallMethod( NumberOfFaces, "for a polygonal complex", [IsVEFComplex],
    function(complex)
            return Length( Faces(complex) );
    end
);


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
##  Implement "faster" access to *Of*-attributes by adding an argument
##

## EdgesOfVertices
InstallMethod(EdgesOfVertexNC, 
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, vertex)
        return EdgesOfVertices(complex)[vertex];
    end
);
InstallMethod(EdgesOfVertex,
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, vertex)
        __SIMPLICIAL_CheckVertex( complex, vertex, "EdgesOfVertex" );
        return EdgesOfVertexNC(complex,vertex);
    end
);

## FacesOfVertices
InstallMethod(FacesOfVertexNC, 
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, vertex)
        return FacesOfVertices(complex)[vertex];
    end
);
InstallMethod(FacesOfVertex,
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, vertex)
        __SIMPLICIAL_CheckVertex( complex, vertex, "FacesOfVertex" );
        return FacesOfVertexNC(complex,vertex);
    end
);


## VerticesOfEdges
InstallMethod(VerticesOfEdgeNC, 
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, edge)
        return VerticesOfEdges(complex)[edge];  
    end
);
InstallMethod(VerticesOfEdge,
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, edge)
        __SIMPLICIAL_CheckEdge( complex, edge, "VerticesOfEdge" );
        return VerticesOfEdgeNC(complex,edge);
    end
);


## FacesOfEdges
InstallMethod(FacesOfEdgeNC, 
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, edge)
        return FacesOfEdges(complex)[edge]; 
    end
);
InstallMethod(FacesOfEdge,
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, edge)
        __SIMPLICIAL_CheckEdge( complex, edge, "FacesOfEdge" );
        return FacesOfEdgeNC(complex,edge);
    end
);


## VerticesOfFaces
InstallMethod(VerticesOfFaceNC, 
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, face)
        return VerticesOfFaces(complex)[face];
    end
);
InstallMethod(VerticesOfFace,
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, face)
        __SIMPLICIAL_CheckFace( complex, face, "VerticesOfFace" );
        return VerticesOfFaceNC(complex,face);
    end
);


## EdgesOfFaces
InstallMethod(EdgesOfFaceNC, 
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, face)
        return EdgesOfFaces(complex)[face];    
    end
);
InstallMethod(EdgesOfFace,
    "for a polygonal complex and a positive integer",
    [IsVEFComplex, IsPosInt],
    function(complex, face)
        __SIMPLICIAL_CheckFace( complex, face, "EdgesOfFace" );
        return EdgesOfFaceNC(complex,face);
    end
);


##
##          End of basic access (*Of*)
##
##############################################################################



#############################################################################
##
##          Start of specialized access
##
InstallMethod( EdgesInFaceByVerticesNC,
    "for a VEF-complex, a face, and a set of two vertices",
    [IsVEFComplex, IsPosInt, IsSet],
    function( complex, face, vertSet )
        return Filtered( EdgesOfFaces(complex)[face], e ->
            VerticesOfEdges(complex)[e] = vertSet);
    end
);
InstallMethod( EdgesInFaceByVerticesNC,
    "for a VEF-complex, a face, and a list of two vertices",
    [IsVEFComplex, IsPosInt, IsList],
    function( complex, face, vertList )
        return EdgesInFaceByVerticesNC(complex, face, Set(vertList));
    end
);
InstallMethod( EdgesInFaceByVertices,
    "for a VEF-complex, a face, and a set of two vertices",
    [IsVEFComplex, IsPosInt, IsSet],
    function( complex, face, vertSet )
        __SIMPLICIAL_CheckFace(complex, face, "EdgesInFaceByVertices");
        return EdgesInFaceByVerticesNC(complex, face, vertSet);
    end
);
InstallMethod( EdgesInFaceByVertices,
    "for a VEF-complex, a face, and a list of two vertices",
    [IsVEFComplex, IsPosInt, IsList],
    function( complex, face, vertList )
        return EdgesInFaceByVertices(complex, face, Set(vertList));
    end
);


InstallMethod( EdgeInFaceByVerticesNC, 
    "for a VEF-complex, a face, and a set of two vertices",
    [IsVEFComplex, IsPosInt, IsSet],
    function( complex, face, vertSet )
        local possEdges;

        possEdges := EdgesInFaceByVerticesNC(complex, face, vertSet);
        if Length(possEdges) = 0  or Length(possEdges) > 1 then
            return fail;
        fi;
        return possEdges[1];
    end
);
InstallMethod( EdgeInFaceByVerticesNC,
    "for a VEF-complex, a face, and a list of two vertices",
    [IsVEFComplex, IsPosInt, IsList],
    function( complex, face, vertList )
        return EdgeInFaceByVerticesNC(complex, face, Set(vertList));
    end
);
InstallMethod( EdgeInFaceByVertices,
    "for a VEF-complex, a face, and a set of two vertices",
    [IsVEFComplex, IsPosInt, IsSet],
    function( complex, face, vertSet )
        __SIMPLICIAL_CheckFace(complex, face, "EdgeInFaceByVertices");
        return EdgeInFaceByVerticesNC(complex, face, vertSet);
    end
);
InstallMethod( EdgeInFaceByVertices,
    "for a VEF-complex, a face, and a list of two vertices",
    [IsVEFComplex, IsPosInt, IsList],
    function( complex, face, vertList )
        return EdgeInFaceByVertices(complex, face, Set(vertList));
    end
);


#######################################

InstallMethod( OtherEdgesOfVertexInFaceNC,
    "for a VEF-complex, a vertex, an edge, and a face",
    [IsVEFComplex, IsPosInt, IsPosInt, IsPosInt],
    function( complex, vertex, edge, face )
        local possEdges, poss, verts, res;

        possEdges := EdgesOfFaces(complex)[face];
        res := [];
        for poss in possEdges do
            if poss <> edge then
                verts := VerticesOfEdges(complex)[poss];
                if vertex in verts then # Should this be done manually for polygonal complexes?
                    Add(res, poss);
                fi;
            fi;
        od;

        return res;
    end
);
InstallMethod( OtherEdgesOfVertexInFace,
    "for a VEF-complex, a vertex, an edge, and a face",
    [IsVEFComplex, IsPosInt, IsPosInt, IsPosInt],
    function( complex, vertex, edge, face )
        local name;

        name := "OtherEdgesOfVertexInFace";
        __SIMPLICIAL_CheckVertex(complex, vertex, name);
        __SIMPLICIAL_CheckEdge(complex, edge, name);
        __SIMPLICIAL_CheckFace(complex, face, name);
        __SIMPLICIAL_CheckIncidenceVertexEdge(complex, vertex, edge, name);
        __SIMPLICIAL_CheckIncidenceEdgeFace(complex, edge, face, name);

        return OtherEdgesOfVertexInFaceNC(complex, vertex, edge, face);
    end
);


InstallMethod( OtherEdgeOfVertexInFaceNC,
    "for a polygonal complex, a vertex, an edge, and a face",
    [IsPolygonalComplex, IsPosInt, IsPosInt, IsPosInt],
    function( complex, vertex, edge, face )
        local possEdges, poss, verts;

        possEdges := EdgesOfFaces(complex)[face];
        for poss in possEdges do
            if poss <> edge then
                verts := VerticesOfEdges(complex)[poss];
                if vertex = verts[1] or vertex = verts[2] then
                    return poss;
                fi;
            fi;
        od;

        Error("OtherEdgeOfVertexInFaceNC: No valid edge found.");
    end
);
InstallMethod( OtherEdgeOfVertexInFaceNC,
    "for a bend polygonal complex, a vertex, an edge, and a face",
    [IsBendPolygonalComplex, IsPosInt, IsPosInt, IsPosInt],
    function( complex, vertex, edge, face )
        local possEdges;

        possEdges := OtherEdgesOfVertexInFaceNC(complex,vertex,edge,face);
        if Length(possEdges) <> 1 then
            return fail;
        else
            return possEdges[1];
        fi;
    end
);
InstallMethod( OtherEdgeOfVertexInFace,
    "for a VEF-complex, a vertex, an edge, and a face",
    [IsVEFComplex, IsPosInt, IsPosInt, IsPosInt],
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

#######################################

InstallMethod( OtherVertexOfEdgeNC,
    "for a polygonal complex, a vertex, and an edge",
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
InstallMethod( OtherVertexOfEdgeNC,
    "for a bend polygonal complex, a vertex, and an edge",
    [IsBendPolygonalComplex, IsPosInt, IsPosInt],
    function( complex, vertex, edge )
        local possVert;
        
        possVert := VerticesOfEdges(complex)[edge];
        if Length(possVert) = 1 then
            return possVert[1];
        fi;

        if vertex = possVert[1] then
            return possVert[2];
        else
            return possVert[1];
        fi;
    end
);
InstallMethod( OtherVertexOfEdge,
    "for a VEF-complex, a vertex, and an edge",
    [IsVEFComplex, IsPosInt, IsPosInt],
    function( complex, vertex, edge )
        local name;
        
        name := "OtherVertexOfEdge";
        __SIMPLICIAL_CheckEdge(complex, edge, name);
        __SIMPLICIAL_CheckIncidenceVertexEdge(complex, vertex, edge, name);
        return OtherVertexOfEdgeNC(complex, vertex, edge);
    end
);

#######################################

InstallMethod( NeighbourFacesByEdgeNC,
    "for a polygonal complex, a face, and an edge",
    [IsPolygonalComplex, IsPosInt, IsPosInt],
    function(complex,face,edge)
        local possFaces;

        possFaces := FacesOfEdges(complex)[edge];
        if Length(possFaces) = 1 then
            return [];
        fi;

        if Length(possFaces) = 2 then
            if possFaces[1] = face then
                return [possFaces[2]];
            else
                return [possFaces[1]];
            fi;
        fi;

        return Difference(possFaces, [face]);
    end
);
InstallMethod( NeighbourFacesByEdgeNC,
    "for a bend polygonal complex, a face, and an edge",
    [IsBendPolygonalComplex, IsPosInt, IsPosInt],
    function(complex, face, edge)
        local possFlags, neigh, faces;

        # Which flags are incident to this face-edge-pair?
        possFlags := Intersection( LocalFlagsOfFaces(complex)[face], LocalFlagsOfEdges(complex)[edge] );

        neigh := Filtered( LocalFlagsOfHalfEdges(complex), p -> possFlags[1] in p )[1];
        neigh := Difference( neigh, [possFlags[1]] );

        faces := List(neigh, n -> FacesOfLocalFlags(complex)[n]);
        return Set(faces);
    end
);

InstallMethod( NeighbourFaceByEdgeNC,
    "for a polygonal complex, a face, and an edge",
    [IsPolygonalComplex, IsPosInt, IsPosInt],
    function( complex, face, edge )
        local possFaces;
        
        possFaces := FacesOfEdges(complex)[edge];
        if Length(possFaces) <> 2 then
            return fail;
        fi;

        if possFaces[1] = face then
            return possFaces[2];
        else
            return possFaces[1];
        fi;
    end
);
InstallMethod( NeighbourFaceByEdgeNC,
    "for a bend polygonal complex, a face, and an edge",
    [IsBendPolygonalComplex, IsPosInt, IsPosInt],
    function(complex, face, edge)
        local poss;

        poss := NeighbourFacesByEdgeNC(complex,face,edge);
        if Length(poss) = 1 then
            return poss[1];
        else
            return fail;
        fi;
    end
);


InstallMethod( NeighbourFaceByEdge,
    "for a VEF-complex, a face, and an edge",
    [IsVEFComplex, IsPosInt, IsPosInt],
    function( complex, face, edge )
        local name;
        
        name := "NeighbourFaceByEdge";
        __SIMPLICIAL_CheckEdge(complex,edge, name);
        __SIMPLICIAL_CheckFace(complex, face, name);
        __SIMPLICIAL_CheckIncidenceEdgeFace(complex, edge, face, name);
        
        return NeighbourFaceByEdgeNC(complex, face, edge);
    end
);
InstallMethod( NeighbourFacesByEdge,
    "for a VEF-complex, a face, and an edge",
    [IsVEFComplex, IsPosInt, IsPosInt],
    function( complex, face, edge )
        local name;
        
        name := "NeighbourFacesByEdge";
        __SIMPLICIAL_CheckEdge(complex,edge, name);
        __SIMPLICIAL_CheckFace(complex, face, name);
        __SIMPLICIAL_CheckIncidenceEdgeFace(complex, edge, face, name);
        
        return NeighbourFacesByEdgeNC(complex, face, edge);
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
__SIMPLICIAL_AddVEFAttribute(PerimeterPathsOfFaces);


# the wrappers
InstallMethod( PerimeterPathOfFaceNC, 
    "for a VEF-complex and a face (positive integer)",
    [IsVEFComplex, IsPosInt],
    function(complex, face)
        return PerimeterPathsOfFaces(complex)[face];
    end
);
InstallMethod( PerimeterPathOfFace,
    "for a VEF-complex and a face (positive integer)",
    [IsVEFComplex, IsPosInt],
    function(complex, face)
        __SIMPLICIAL_CheckFace(complex, face, "PerimeterPathOfFace");
        return PerimeterPathOfFaceNC(complex, face);
    end
);


# main computation method
InstallMethod( PerimeterPathsOfFaces, "for a polygonal complex", 
    [IsPolygonalComplex],
    function(complex)
        local paths, f, localVertices, startVert, adEdges,
            i, localPath, len, perim;

        paths := [];
        perim := [];
        for f in Faces(complex) do
            localVertices := VerticesOfFaces(complex)[f];
            startVert := Minimum(localVertices);
            adEdges := Intersection( EdgesOfFaces(complex)[f],
                        EdgesOfVertices(complex)[startVert]);
            Assert(1, adEdges[1]<>adEdges[2]);

            if adEdges[1] < adEdges[2] then
                localPath := [ startVert, adEdges[1], OtherVertexOfEdgeNC(complex,startVert,adEdges[1]) ];
            else
                localPath := [ startVert, adEdges[2], OtherVertexOfEdgeNC(complex,startVert,adEdges[2]) ];
            fi;
            

            for i in [2..Length(localVertices)] do # How long will the path be?
                len := Length(localPath);
                Add( localPath, OtherEdgeOfVertexInFaceNC(complex,
                        localPath[len],localPath[len-1],f) );
                Add( localPath, OtherVertexOfEdgeNC(complex,
                        localPath[len],localPath[len+1]) );
            od;
            Assert(1, localPath[1] = localPath[Length(localPath)]);
            paths[f] := VertexEdgePathNC(complex, localPath);
            perim[f] := PerimeterPathNC(paths[f], f);
        od;

        return perim;
    end
);

AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "PerimeterPathsOfFaces", ["Faces", "VerticesOfFaces", "EdgesOfFaces", 
        "VerticesOfEdges", "EdgesOfVertices"], ["IsPolygonalComplex"]);

# TODO document ordering
InstallMethod( PerimeterPathsOfFaces,
    "for a bend polygonal complex with Faces, VerticesOfFaces, LocalVerticesOfVertices, LocalVerticesOfFaces, EdgesOfLocalEdges, VerticesOfLocalVertices",
    [IsBendPolygonalComplex and HasFaces and HasVerticesOfFaces and 
        HasLocalVerticesOfVertices and HasLocalVerticesOfFaces and
        HasEdgesOfLocalEdges and HasVerticesOfLocalVertices],
    function(bendComplex)
        local perim, f, localFace, verts, startVert, locVerts, startLoc, obj,
            locEdges, edges, localPath, path, i, len, localVE, localPerim;

        perim := [];
        for f in Faces(bendComplex) do
            localFace := LocalFace(bendComplex, f);

            # Find the starting vertex
            verts := VerticesOfFaces(bendComplex)[f];
            startVert := Minimum(verts);
            locVerts := Intersection( 
                LocalVerticesOfVertices(bendComplex)[startVert],
                LocalVerticesOfFaces(bendComplex)[f] );
            startLoc := Minimum(locVerts);

            # Find the next edge
            locEdges := EdgesOfVertices(localFace)[startLoc];
            edges := EdgesOfLocalEdges(bendComplex){locEdges};

            if edges[1] = edges[2] then
                # tie-breaker by local edges
                if locEdges[1] < locEdges[2] then
                    localPath := [ startLoc, locEdges[1] ];
                    path := [ startVert, edges[1] ];
                else
                    localPath := [ startLoc, locEdges[2] ];
                    path := [ startVert, edges[2] ];
                fi;
            elif edges[1] < edges[2] then
                localPath := [ startLoc, locEdges[1] ];
                path := [ startVert, edges[1] ];
            else
                localPath := [ startLoc, locEdges[1] ];
                path := [ startVert, edges[1] ];
            fi;
            Add(localPath, OtherVertexOfEdgeNC(localFace, localPath[1], localPath[2]));
            Add(path, VerticesOfLocalVertices(bendComplex)[localPath[3]]);


            for i in [2..NumberOfEdges(localFace)] do # How long will the path be?
                len := Length(localPath);

                Add( localPath, OtherEdgeOfVertexInFaceNC(localFace, 
                    localPath[len], localPath[len-1],f) );
                Add( localPath, OtherVertexOfEdgeNC(localFace, 
                    localPath[len], localPath[len+1]) );

                Add( path, EdgesOfLocalEdges(bendComplex)[localPath[len+1]] );
                Add( path, VerticesOfLocalVertices(bendComplex)[localPath[len+2]] );
            od;
            Assert(1, localPath[1] = localPath[Length(localPath)]);

            localVE := VertexEdgePathNC(localFace, localPath);
            localPerim := PerimeterPathNC(localVE, f);

            obj := Objectify( PerimeterPathType, rec() );
            SetPath(obj, path);
            SetLocalPath( obj, localPerim );
            SetAssociatedVEFComplex(obj, bendComplex);
            SetFace(obj, f);

            perim[f] := obj;
        od;

        return perim;
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, "PerimeterPathsOfFaces", 
    ["Faces", "VerticesOfFaces", "LocalVerticesOfVertices", 
        "LocalVerticesOfFaces", "EdgesOfLocalEdges", 
        "VerticesOfLocalVertices"],
    ["IsBendPolygonalComplex"]);


# inferences from the perimeter path
InstallMethod( VerticesOfFaces, 
    "for a VEF-complex with PerimeterPathsOfFaces",
    [IsVEFComplex and HasPerimeterPathsOfFaces],
    function(complex)
        return List( PerimeterPathsOfFaces(complex), p -> Set(VerticesAsList(p)) );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "VerticesOfFaces", ["PerimeterPathsOfFaces"] );


InstallMethod( EdgesOfFaces, 
    "for a VEF-complex with PerimeterPathsOfFaces",
    [IsVEFComplex and HasPerimeterPathsOfFaces],
    function(complex)
        return List( PerimeterPathsOfFaces(complex), p -> Set(EdgesAsList(p)) );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "EdgesOfFaces", ["PerimeterPathsOfFaces"] );


InstallMethod( Faces,
    "for a VEF-complex that has PerimeterPathsOfFaces",
    [IsVEFComplex and HasPerimeterPathsOfFaces],
    function(complex)
        return __SIMPLICIAL_BoundPositions( PerimeterPathsOfFaces(complex) );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "Faces", "PerimeterPathsOfFaces");

##
##          End of face-induced order
##
##############################################################################




##############################################################################
##
##      Edge-Face-Paths around vertices
##
__SIMPLICIAL_AddVEFAttribute(UmbrellaPartitionsOfVertices);
__SIMPLICIAL_AddVEFAttribute(UmbrellasOfVertices);

##
## Implement the immediate methods for inferences about the complex
##
InstallImmediateMethod( IsNotVertexRamified, 
    "for a VEF-complex that has UmbrellasOfVertices",
    IsVEFComplex and HasUmbrellasOfVertices, 0,
    function(complex)
        return not fail in UmbrellasOfVertices(complex);
    end
);
AddPropertyIncidence(SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "IsNotVertexRamified", "UmbrellasOfVertices");

InstallImmediateMethod( IsNotEdgeRamified,
    "for a VEF-complex that has UmbrellaPartitionsOfVertices",
    IsVEFComplex and HasUmbrellaPartitionsOfVertices, 0,
    function(complex)
        return not fail in UmbrellaPartitionsOfVertices(complex);
    end
);
AddPropertyIncidence(SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "IsNotEdgeRamified", "UmbrellaPartitionsOfVertices");

##
## We will implement the connections between singular paths and partitions
## first. Afterward we will connect the partitions with everything else.
##

InstallMethod( UmbrellasOfVertices,
    "for a VEF-surface that has UmbrellaPartitionsOfVertices",
    [IsVEFSurface and HasUmbrellaPartitionsOfVertices],
    function( surface )
        local umbPart, v, res;

        res := [];
        umbPart := UmbrellaPartitionsOfVertices(surface);
        for v in VerticesAttributeOfVEFComplex(surface) do
            res[v] := umbPart[v][1];
        od;
        return res;
    end
);

InstallMethod( UmbrellasOfVertices,
    "for a VEF-complex that has UmbrellaPartitionsOfVertices",
    [IsVEFComplex and HasUmbrellaPartitionsOfVertices],
    function(ramSurf)
        local FirstOrFail;

        FirstOrFail := function(list)
            if list = fail then
                return fail;
            elif Length(list) = 1 then
                return list[1];
            else
                return fail;
            fi;
        end;

        return List( UmbrellaPartitionsOfVertices(ramSurf), FirstOrFail );
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "UmbrellasOfVertices", 
    ["UmbrellaPartitionsOfVertices"]);



InstallImmediateMethod( UmbrellaPartitionsOfVertices,
    "for a VEF-complex without edge ramifications that has UmbrellasOfVertices",
    IsVEFComplex and IsNotEdgeRamified and HasUmbrellasOfVertices, 0,
    function( ramSurf )
        return List( UmbrellasOfVertices(ramSurf), p -> [p] );
    end
);


## Methods for one single vertex
InstallMethod( UmbrellaOfVertexNC, "for a VEF-complex and a vertex",
    [IsVEFComplex, IsPosInt],
    function( surface, vertex )
        return UmbrellasOfVertices(surface)[vertex];
    end
);
InstallMethod( UmbrellaOfVertex, "for a VEF-complex and a vertex",
    [IsVEFComplex, IsPosInt],
    function( surface, vertex )
        __SIMPLICIAL_CheckVertex(surface,vertex, "UmbrellaOfVertex");
        return UmbrellaOfVertexNC(surface, vertex);
    end
);

InstallMethod( UmbrellaPartitionOfVertexNC,
    "for a VEF-complex and a vertex",
    [IsVEFComplex, IsPosInt],
    function( ramSurf, vertex )
        return UmbrellaPartitionsOfVertices(ramSurf)[vertex];
    end
);
InstallMethod( UmbrellaPartitionOfVertex,
    "for a VEF-complex and a vertex",
    [IsVEFComplex, IsPosInt],
    function( ramSurf, vertex )
        __SIMPLICIAL_CheckVertex(ramSurf, vertex, "UmbrellaPartitionOfVertex");
        return UmbrellaPartitionOfVertexNC(ramSurf, vertex);
    end
);

##
## Implications from UmbrellaPartitionsOfVertices (only to *Of*, since 
## implications to vertices, edges and faces follow from that)
##

#TODO It might be useful to compute IsNotEdgeRamified for the possibility of simplifying the calculations
InstallMethod( EdgesOfVertices, 
    "for a VEF-complex without edge ramifications that has UmbrellaPartitionsOfVertices", 
    [IsVEFComplex and IsNotEdgeRamified and HasUmbrellaPartitionsOfVertices],
    function(complex)
        return List( UmbrellaPartitionsOfVertices(complex), part ->
            __SIMPLICIAL_UnionSets( List( part, EdgesAsList ) ));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "EdgesOfVertices", 
    ["UmbrellaPartitionsOfVertices"], ["IsNotEdgeRamified"]);

InstallMethod( FacesOfVertices,
    "for a VEF-complex without edge ramifications that has UmbrellaPartitionsOfVertices",
    [IsVEFComplex and IsNotEdgeRamified and HasUmbrellaPartitionsOfVertices],
    function(complex)
        return List( UmbrellaPartitionsOfVertices(complex), part ->
            __SIMPLICIAL_UnionSets( List( part, FacesAsList ) ));
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER,
    "FacesOfVertices", 
    ["UmbrellaPartitionsOfVertices"], ["IsNotEdgeRamified"]);

InstallMethod( FacesOfEdges,
    "for a VEF-complex without edge ramifications that has UmbrellaPartitionsOfVertices and VerticesAttributeOfVEFComplex",
    [IsVEFComplex and IsNotEdgeRamified and HasUmbrellaPartitionsOfVertices and HasVerticesAttributeOfVEFComplex],
    function(complex)
        local facesOfEdges, parts, v, p, even, ind, i, edge, incFaces, path;

        parts := UmbrellaPartitionsOfVertices(complex);

        facesOfEdges := [];
        for v in VerticesAttributeOfVEFComplex(complex) do
            for p in parts[v] do
                path := PathAsList(p);

                for i in [1..(Length(path)+1)/2] do
                    edge := path[2*i-1];
                    if IsBound(facesOfEdges[edge]) then
                        # Since the complex is ramified, the incident faces should be the same
                        continue;
                    fi;

                    if i = 1 and IsClosedPath(p) then
                        incFaces := Set([ path[2], path[Length(path)-1] ]);
                    elif i = 1 then
                        incFaces := [path[2]];
                    elif not IsClosedPath(p) and 2*i = Length(path)+1 then
                        incFaces := [path[Length(path)-1]];
                    else
                        incFaces := Set( [path[2*i-2],path[2*i]] );
                    fi;
                    facesOfEdges[edge] := incFaces;
                od;
            od;
        od;

        return facesOfEdges;
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, "FacesOfEdges", 
    ["UmbrellaPartitionsOfVertices", "VerticesAttributeOfVEFComplex"], 
    ["IsNotEdgeRamified"]);


InstallMethod( UmbrellaPartitionsOfVertices, 
    "for a polygonal complex that has VerticesAttributeOfVEFComplex, EdgesOfVertices, EdgesOfFaces, FacesOfEdges, VerticesOfEdges and RamifiedEdges",
    [IsPolygonalComplex and HasVerticesAttributeOfVEFComplex and 
        HasEdgesOfVertices and HasEdgesOfFaces and HasFacesOfEdges and 
        HasVerticesOfEdges and HasRamifiedEdges],
    function(ramSurf)
        local faceEdgePathPart, vertex, incidentEdges, paths,
            edgeStart, possFaces, rightFinished, leftFinished, backFace, path,
            nextEdge, nextFace, usedEdges;

        faceEdgePathPart := [];

        for vertex in VerticesAttributeOfVEFComplex(ramSurf) do
            incidentEdges := EdgesOfVertices(ramSurf)[vertex];
            paths := [];

            while Length(incidentEdges) > 0 do
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
                usedEdges := [];
                while not rightFinished or not leftFinished do
                    # Try to extend the path beyond the last face
                    nextEdge := OtherEdgeOfVertexInFaceNC(ramSurf, vertex, 
                            path[Length(path)-1], path[Length(path)]); 
                            # calls EdgesOfFaces and VerticesOfEdges
                    Add(usedEdges, nextEdge);

                    nextFace := NeighbourFaceByEdgeNC(ramSurf, 
                        path[Length(path)], nextEdge); # calls FacesOfEdges
                    if nextFace = fail then
                        # check if we had a branch
                        if nextEdge in RamifiedEdges(ramSurf) then
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

                if IsEvenInt( Length(path) ) then
                    # It is a closed path
                    Add(path, path[1]);
                fi;
                Add(paths, EdgeFacePathNC(ramSurf,path));
                incidentEdges := Difference( incidentEdges, usedEdges );
            od;

            faceEdgePathPart[vertex] := paths;
        od;

        return faceEdgePathPart;
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "UmbrellaPartitionsOfVertices", 
    ["VerticesAttributeOfVEFComplex", "EdgesOfVertices", "EdgesOfFaces", 
        "FacesOfEdges", "VerticesOfEdges", "RamifiedEdges"], ["IsPolygonalComplex"]);

InstallMethod( UmbrellaPartitionsOfVertices, 
    Concatenation("for a bend polygonal complex that has ",
        "VerticesAttributeOfVEFComplex and LocalVerticesOfVertices and ",
        "FacesOfLocalVertices and LocalEdgesOfLocalVertices and ",
        "LocalEdgesOfLocalFlags and EdgesOfLocalFlags and ",
        "LocalFlagsOfHalfEdges and HalfEdgesOfLocalFlags"),
    [IsBendPolygonalComplex and HasVerticesAttributeOfVEFComplex and 
        HasLocalVerticesOfVertices and HasFacesOfLocalVertices and 
        HasLocalEdgesOfLocalVertices and HasLocalEdgesOfLocalFlags and
        HasEdgesOfLocalFlags and HasHalfEdgesOfLocalFlags and 
        HasLocalFlagsOfHalfEdges],
    function(bendComplex)
        local umbrellaPart, elements, v, paths, locVertices, usedVertices,
            localEdges, face, currPath, i, part, neigh, flagOut, p, forward,
            nextFlag, umbs, elementList, efList, he;

        umbrellaPart := [];
        for v in VerticesAttributeOfVEFComplex(bendComplex) do
            paths := [];

            locVertices := LocalVerticesOfVertices(bendComplex)[v];

            while Length(locVertices) > 0 do
                # Start a path with the first local vertex
                usedVertices := [locVertices[1]];
                localEdges := LocalEdgesOfLocalVertices(bendComplex)[locVertices[1]];
                face := FacesOfLocalVertices(bendComplex)[locVertices[1]];

                # Store the path as [localFlagIn, localFlagOut]
                currPath := [ [ LocalFlagByLocalVertexLocalEdgeFace(bendComplex, locVertices[1], localEdges[1], face), 
                    LocalFlagByLocalVertexLocalEdgeFace(bendComplex, locVertices[1], localEdges[2], face)] ];

                forward := true;

                for i in [1..2*Length(locVertices)] do  # Safeguard against infinite loop
                    # Find local flags adjacent to the last flag
                    flagOut := currPath[Length(currPath)][2];
                    he := HalfEdgesOfLocalFlags(bendComplex)[flagOut];
                    part := LocalFlagsOfHalfEdges(bendComplex)[he];

                    if Length(part) = 1 then
                        # We found a boundary
                        if forward then
                            # Reverse course
                            currPath := Reversed(currPath);
                            currPath := List(currPath, Reversed);
                            continue;
                        else
                            # we found both ends
                            break;
                        fi;
                    elif Length(part) > 2 then
                        # no umbrella partition exists
                        currPath := fail;
                        break;
                    else
                        # Exactly one neighbour
                        if part[1] = flagOut then
                            neigh := part[2];
                        else
                            neigh := part[1];
                        fi;

                        # Check if the path closes
                        if neigh = currPath[1][1] then
                            break;
                        fi;

                        nextFlag := neigh^LocalFlagVertexInvolution(bendComplex);
                        Add(currPath, [neigh,nextFlag]);
                        Add(usedVertices, LocalVerticesOfLocalFlags(bendComplex)[neigh]);
                    fi;
                od;

                if currPath = fail then
                    paths := fail;
                    break;
                fi;
                Add(paths, currPath);
                locVertices := Difference(locVertices, usedVertices);
            od;

            # Transform paths into proper umbrellas
            #TODO orient correctly
            if paths = fail then
                umbrellaPart[v] := fail;
            else
                umbs := [];
                for p in paths do
                    elementList := List(p, t -> [FacesOfLocalFlags(bendComplex)[t[1]], LocalEdgesOfLocalFlags(bendComplex){t}]);
                    efList := List(p, t -> [EdgesOfLocalFlags(bendComplex)[t[1]], FacesOfLocalFlags(bendComplex)[t[1]]  ]);
                    Add(efList, EdgesOfLocalFlags(bendComplex)[p[Length(p)][2]]);
                    Add(umbs, EdgeFacePath(bendComplex, Flat(efList), elementList));
                od;
                umbrellaPart[v] := umbs;
            fi;
        od;

        return umbrellaPart;
    end
);
AddPropertyIncidence( SIMPLICIAL_ATTRIBUTE_SCHEDULER, 
    "UmbrellaPartitionsOfVertices", 
    ["VerticesAttributeOfVEFComplex", "LocalVerticesOfVertices", 
    "FacesOfLocalVertices", "LocalEdgesOfLocalVertices", 
    "LocalEdgesOfLocalFlags", "EdgesOfLocalFlags", "LocalFlagsOfHalfEdges",
    "HalfEdgesOfLocalFlags"], ["IsBendPolygonalComplex"]);
#
##
##          End of edge-face-paths
##
##############################################################################


##############################################################################
##
##          Start of HolePerimeter
##
InstallMethod( PerimeterOfHoles, "for a polygonal surface",
    [IsPolygonalSurface], 
    function(surface)
        local boundVerts, boundEdges, res, transVert, e, incVert,
            transEdge, v, umb, path, incEdges, adVertices, lastEdge,
            lastVertex, nextEdge, nextVertex, vePath, incEdge;

        # Find all boundary edges and encode the incident vertices
        # as transpositions
        boundEdges := BoundaryEdges(surface);
        transVert := [];

        boundVerts := BoundaryVertices(surface);
        transEdge := [];
        incEdge := [];
        for v in boundVerts do
            incEdge[v] := [];
        od;

        for e in boundEdges do
            incVert := VerticesOfEdges(surface)[e];
            transVert[e] := (incVert[1],incVert[2]);
            Add( incEdge[incVert[1]], e );
            Add( incEdge[incVert[2]], e );
        od;

        # Find all boundary vertices and encode the incident boundary
        # edges as transpositions
        for v in boundVerts do
            transEdge[v] := (incEdge[v][1],incEdge[v][2]);
        od;


        res := [];
        while Length(boundVerts) <> 0 do
            path := [ boundVerts[1] ];
            incEdges := incEdge[path[1]];
            adVertices := [ path[1]^transVert[incEdges[1]], path[1]^transVert[incEdges[2]] ];
            if adVertices[1] < adVertices[2] then
                Append(path, [incEdges[1],adVertices[1]]);
            elif adVertices[2] < adVertices[1] then
                Append(path, [incEdges[2],adVertices[2]]);
            else # incEdge only consists of sets (by construction)
                Append(path, [incEdges[1],adVertices[1]]);
            fi;

            lastEdge := path[2];
            lastVertex := path[3];
            while path[1] <> path[ Length(path) ] do
                nextEdge := lastEdge^transEdge[lastVertex];
                nextVertex := lastVertex^transVert[nextEdge];
                
                Append(path, [nextEdge, nextVertex]);
                
                lastEdge := nextEdge;
                lastVertex := nextVertex;
            od;

            vePath := VertexEdgePathNC(surface, path);
            Add(res, vePath);
            boundVerts := Difference( boundVerts, VerticesAsList(vePath) );
        od;

        return Set(res);
    end
);
RedispatchOnCondition( PerimeterOfHoles, true, [IsPolygonalComplex], [IsPolygonalSurface], 0 );
