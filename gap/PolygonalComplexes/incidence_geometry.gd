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

#! @Chapter Access to the incidence geometry
#! @ChapterLabel AccessIncidenceGeometry
#! 
#! We have introduced incidence geometries in section
#! <Ref Sect="PolygonalStructures_complex"/> as a description of polygonal
#! complexes. In this
#! chapter we will collect different ways to access these incidence
#! structures.


#! @Section Basic access to the incidence structure
#! @SectionLabel Access_BasicAccess
#!
#! In polygonal complexes (the most general supported incidence structure,
#! compare chapter <Ref Chap="PolygonalStructures"/>) all vertices, edges
#! and faces are labelled by positive integers. We can access the set of
#! all those labels by <K>Vertices</K>, <K>Edges</K> and <K>Faces</K>.


#! @BeginGroup
## TODO check if grape has changed their definition of Vertices
#! @Description
#! Return the set of vertices.
#! <Par/>
#! We have separated the operation <K>Vertices</K> from the corresponding
#! attribute because there was a naming clash with the package grape.
#! @Arguments complex
#! @Returns A set of positive integers
DeclareOperation( "Vertices", [IsPolygonalComplex] );
#! @Arguments complex
DeclareAttribute( "VerticesAttributeOfPolygonalComplex", IsPolygonalComplex );
#! @EndGroup

#! @Description
#! Return the set of edges.
#! @Arguments complex
#! @Returns A set of positive integers
DeclareAttribute( "Edges", IsPolygonalComplex );

#! @Description
#! Return the set of faces.
#! @Arguments complex
#! @Returns A set of positive integers
DeclareAttribute( "Faces", IsPolygonalComplex );

#TODO where to put NrOf* ?

#! <Par/>
#! With these labels we can describe the incidence structure by lists of sets.
#! All those methods have the form *Of*, e.g. <K>VerticesOfEdges</K> and 
#! <K>FacesOfVertices</K>.
#! <Par/>
#! We will illustrate the general pattern of these methods by showcasing
#! these two methods. For that we will use the following polygonal complex:
#TODO Text-version is crucial here, compare the picture in Image_StarOfStar
#! <Alt Only="TikZ">
#! {
#! \def\allLabels{1}
#! \input{Image_StarOfStarExample.tex}
#! }
#! </Alt>
#!
#! @BeginExample
complex := PolygonalComplexByDownwardIncidence( 5, 6, 2, 
    [ , , , , , [2,11], , [2,3], [3,11], [3,5], , [5,7], [7,11] ], 
    [[6,8,9], , , [9,10,12,13]]);;
Vertices(complex);
#! [ 2, 3, 5, 7, 11 ]
Edges(complex);
#! [ 6, 8, 9, 10, 12, 13 ]
Faces(complex);
#! [ 1, 4 ]
#! @EndExample
#!
#! 
#!

