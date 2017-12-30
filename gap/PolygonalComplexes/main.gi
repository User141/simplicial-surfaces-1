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

# Set up the attribute scheduler
BindGlobal( "SIMPLICIAL_ATTRIBUTE_SCHEDULER", AttributeSchedulerGraph([]) );

# Set up a global variable to check if the manual is currently built
BindGlobal( "__SIMPLICIAL_MANUAL_MODE", false );
MakeReadWriteGlobal( "__SIMPLICIAL_MANUAL_MODE" );


#TODO make this method a native part of the attribute scheduler
BindGlobal( "__SIMPLICIAL_AddPolygonalAttribute", 
    function( attr )
        AddAttribute( SIMPLICIAL_ATTRIBUTE_SCHEDULER, attr, IsPolygonalComplex, "for a polygonal complex" );
    end
);

BindGlobal( "__SIMPLICIAL_AddRamifiedAttribute",
    function( attr )
        InstallMethod(attr, "for a ramified polygonal surface",
            [IsRamifiedPolygonalSurface],
            function( ramSurf )
                return ComputeProperty(SIMPLICIAL_ATTRIBUTE_SCHEDULER,
                    attr, ramSurf);
            end);

        InstallOtherMethod(attr, "for a polygonal complex (to check if ramified)",
            [IsPolygonalComplex],
            function(complex)
                if HasIsRamifiedPolygonalSurface(complex) and IsRamifiedPolygonalSurface(complex) then
                    TryNextMethod();
                fi;
                if not IsRamifiedPolygonalSurface(complex) then
                    Error("Given polygonal complex is not a ramified polygonal surface");
                fi;
                return attr(complex);
            end
        );
    end
);

BindGlobal( "__SIMPLICIAL_AddSurfaceAttribute",
    function( attr )
        InstallMethod(attr, "for a polygonal surface",
            [IsPolygonalSurface],
            function( surface )
                return ComputeProperty(SIMPLICIAL_ATTRIBUTE_SCHEDULER,
                    attr, surface);
            end);

        InstallOtherMethod(attr, "for a polygonal complex (to check if surface)",
            [IsPolygonalComplex],
            function(complex)
                if HasIsPolygonalSurface(complex)and IsPolygonalSurface(complex) then
                    TryNextMethod();
                fi;
                if not IsPolygonalSurface(complex) then
                    Error("Given polygonal complex is not a polygonal surface.");
                fi;
                return attr(complex);
            end
        );
    end
);


##
## General check methods
#TODO should those be made into actual methods?
##
BindGlobal( "__SIMPLICIAL_CheckVertex", 
    function( complex, vertex, name )
        local mes;

        if not vertex in Vertices(complex) then
            mes := Concatenation( name, ": Given vertex ", String(vertex), 
                " does not lie in the given complex." );
            Error(mes);
        fi;
    end
);
BindGlobal( "__SIMPLICIAL_CheckEdge",
    function( complex, edge, name )
        local mes;

        if not edge in Edges(complex) then
            mes := Concatenation( name, ": Given edge ", String(edge), 
                " does not lie in the given complex." );
            Error(mes);
        fi;
    end
);
BindGlobal( "__SIMPLICIAL_CheckFace", 
    function( complex, face, name )
        local mes;

        if not face in Faces(complex) then
            mes := Concatenation( name, ": Given face ", String(face), 
                " does not lie in the given complex." );
            Error(mes);
        fi;
    end
);
BindGlobal( "__SIMPLICIAL_CheckIncidenceVertexEdge",
    function( complex, vertex, edge, name )
        local mes;
        
        if not vertex in VerticesOfEdges(complex)[edge] then
            mes := Concatenation( name, ": Given vertex ", String(vertex),
                " does not lie in given edge ", String(edge),
                " of the given complex.");
            Error(mes);
        fi;
    end
);
BindGlobal( "__SIMPLICIAL_CheckIncidenceEdgeFace",
    function( complex, edge, face, name )
        local mes;
        
        if not edge in EdgesOfFaces(complex)[face] then
            mes := Concatenation( name, ": Given edge ", String(edge),
                " does not lie in given face ", String(face),
                " of the given complex.");
            Error(mes);
        fi;
    end
);

BindGlobal( "__SIMPLICIAL_BoundEntriesOfList",
    function( list )
	return Filtered( [1..Length(list)], i -> IsBound( list[i] ) );
    end
);

##
## Equality and display methods
##

## Equality test
InstallMethod( \=, "for two polygonal complexes", IsIdenticalObj,
    [IsPolygonalComplex, IsPolygonalComplex],
    function(c1, c2)
        return VerticesOfEdges(c1) = VerticesOfEdges(c2) and EdgesOfFaces(c1) = EdgesOfFaces(c2);
    end
);


# Print
InstallMethod( PrintObj, "for a polygonal complex", [IsPolygonalComplex],
    function(complex)
        local str, out;

        str := "";
        out := OutputTextString(str, true);
        if IsSimplicialSurface(complex) then
            PrintTo( out, "SimplicialSurface");
        elif IsPolygonalSurface(complex) then
            PrintTo( out, "PolygonalSurface");
        elif IsRamifiedSimplicialSurface(complex) then
            PrintTo( out, "RamifiedSimplicialSurface");
        elif IsRamifiedPolygonalSurface(complex) then
            PrintTo( out, "RamifiedPolygonalSurface");
        elif IsTriangularComplex(complex) then
            PrintTo( out, "TriangularComplex");
        else
            PrintTo( out, "PolygonalComplex");
        fi;

        PrintTo( out, "ByDownwardIncidenceNC(" );
        PrintTo( out, VerticesOfEdges(complex) );
        PrintTo( out, ", " );
        PrintTo( out, EdgesOfFaces(complex) );
        PrintTo( out, ");" );

        CloseStream(out);

        Print(str);
    end
);

# Display
InstallMethod( Display, "for a polygonal complex", [IsPolygonalComplex],
    function(complex)
        if IsSimplicialSurface(complex) then
            Print("SimplicialSurface");
        elif IsPolygonalSurface(complex) then
            Print("PolygonalSurface");
        elif IsRamifiedSimplicialSurface(complex) then
            Print("RamifiedSimplicialSurface");
        elif IsRamifiedPolygonalSurface(complex) then
            Print("RamifiedPolygonalSurface");
        elif IsTriangularComplex(complex) then
            Print("TriangularComplex");
        else
            Print("PolygonalComplex");
        fi;

        if IsPolygonalSurface(complex) then # more information
            Print( " (" );
            if IsClosedSurface(complex) then
                Print("closed, ");
            fi;
            
            if IsOrientable(complex) then
                Print("orientable, ");
            else
                Print("non-orientable, ");
            fi;

            if IsConnected(complex) then
                Print("Euler-characteristic ", EulerCharacteristic(complex) );
            else
                Print( NumberOfConnectedComponents(complex), " connected components" );
            fi;
            Print( ")\n");
        fi;

        Print( "    Vertices (", NumberOfVertices(complex), "): ", Vertices(complex), "\n" );
        Print( "    Edges (", NumberOfEdges(complex), "): ", Edges(complex), "\n" );
        Print( "    Faces (", NumberOfFaces(complex), "): ", Faces(complex), "\n" );

        Print( "    VerticesOfEdges: ", VerticesOfEdges(complex), "\n" );
        Print( "    VerticesOfFaces: ", VerticesOfFaces(complex), "\n" );
        Print( "    EdgesOfFaces: ", EdgesOfFaces(complex), "\n" );

        Print("\n");
    end
);

