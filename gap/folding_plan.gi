##############################################################################
##
#W  folding_plan.gi          SimplicialSurfaces           Markus Baumeister
##
##
#Y  Copyright (C) 2016-2017, Markus Baumeister, Lehrstuhl B für Mathematik,
#Y  RWTH Aachen
##
##  This file is free software, see license information at the end.
##
##  This file contains the implementation part for the folding plans of the 
##	SimplicialSurfaces package. A folding plan consists of an identification
##	and two oriented faces belongig to the identified faces.
##
##

##
##	We use a representation that doesn't do much.
##
DeclareRepresentation("IsFoldingPlanRep", IsFoldingPlan, []);

##	accompanying type
FoldingPlanType := NewType( FoldingPlanFamily, IsFoldingPlanRep );


#############################################################################
#############################################################################
##
##						Start of constructors
##
##


#!	@Description
#!	Return a folding plan based on an identification and a list of two 
#!	oriented faces (integers).
#!	The NC-version doesn't check whether the list actually consists of exactly
#!	two integers.
#!	@Arguments a simplicial surface identification, a tuple of integers
#!	@Returns a folding plan
InstallMethod( FoldingPlanByIdentificationNC,
	"for a simplicial surface identification and a list of two integers", 
	[IsSimplicialSurfaceIdentification, IsList],
	function( id, orFaceList )
		local plan, source, image, relation, map;

		plan := Objectify( FoldingPlanType, rec() );
		SetIdentificationAttributeOfFoldingPlan( plan, id );

		source := Domain( [ orFaceList[1] ] );
		image := Domain( [ orFaceList[2] ] );
		relation := [ DirectProductElement(orFaceList) ];
		map := GeneralMappingByElements( source, image, relation);

		SetOrientedFaceMapAttributeOfFoldingPlan( plan, map );

		return plan;
	end
);
InstallMethod( FoldingPlanByIdentification,
	"for a simplicial surface identification and a list of two integers", 
	[IsSimplicialSurfaceIdentification, IsList],
	function( id, orFaceList )
		if Length( orFaceList ) <> 2 then
			Error("FoldingPlanByIdentification: List of oriented faces has to contain exactly two faces.");
		fi;
		if not IsInt(orFaceList[1]) or not IsInt(orFaceList[2]) then
			Error("FoldingPlanByIdentification: Oriented faces have to be given as integers.");
		fi;

		return FoldingPlanByIdentificationNC(id, orFaceList);
	end
);

#!	@Description
#!	Return a folding plan based on four maps. The first three define the
#!	identification, the last one is the oriented face map.
#!
#!	The NC-version doesn't check whether the number of elements in these 
#!	maps match (3 vertices, 3 edges, 1 face, 1 oriented face).
#!
#!	@Arguments four bijective maps: for vertices, edges, faces and oriented
#!		faces
#!	@Returns a folding plan
InstallMethod( FoldingPlanByMapsNC, "for four bijective maps", 
	[IsMapping and IsBijective, IsMapping and IsBijective, 
		IsMapping and IsBijective, IsMapping and IsBijective],
	function( vertexMap, edgeMap, faceMap, orFaceMap )
		local id, plan;

		id := SimplicialSurfaceIdentificationNC( vertexMap, edgeMap, faceMap );
		
		plan := Objectify( FoldingPlanType, rec() );
		SetIdentificationAttributeOfFoldingPlan( plan, id );
		SetOrientedFaceMapAttributeOfFoldingPlan( plan, orFaceMap );

		return plan;
	end
);
RedispatchOnCondition( FoldingPlanByMapsNC, true, 
	[IsMapping, IsMapping, IsMapping, IsMapping], 
	[IsBijective, IsBijective, IsBijective, IsBijective], 0 );

InstallMethod( FoldingPlanByMaps, "for four bijective maps", 
	[IsMapping and IsBijective, IsMapping and IsBijective, 
		IsMapping and IsBijective, IsMapping and IsBijective],
	function( vertexMap, edgeMap, faceMap, orFaceMap )
		local id, plan;

		id := SimplicialSurfaceIdentification( vertexMap, edgeMap, faceMap );

		if Length( Source( orFaceMap ) ) <> 1 then
			Error("FoldingPlanByMaps: Only one oriented face");
		fi;
	#TODO check whether orFaceMap really only consists of integers
		
		plan := Objectify( FoldingPlanType, rec() );
		SetIdentificationAttributeOfFoldingPlan( plan, id );
		SetOrientedFaceMapAttributeOfFoldingPlan( plan, orFaceMap );

		return plan;
	end
);
RedispatchOnCondition( FoldingPlanByMaps, true, 
	[IsMapping, IsMapping, IsMapping, IsMapping], 
	[IsBijective, IsBijective, IsBijective, IsBijective], 0 );


#!	@Description
#!	Return a folding plan that is constructed from four lists. The vertex-list 
#!	has the form [[p_1,q_1],[p_2,q_2],[p_3,q_3]] and corresponds to the map 
#!	p_i -> q_i. Analogously for the other three lists.
#!
#!	The NC-version does not check if the lists fulfill this format or if the
#!	number of elements match or if the resulting maps are bijective.
#!
#!	@Arguments three lists of tuples of positive integers, one list of tuples
#!		of integers
#!	@Returns a folding plan
InstallMethod( FoldingPlanByListsNC, "for four lists", 
	[IsList,IsList,IsList,IsList],
	function( vertexList, edgeList, faceList, orFaceList )
		local id, plan;

		id := SimplicialSurfaceIdentificationByListsNC( 
										vertexList, edgeList, faceList );
		
		plan := Objectify( FoldingPlanType, rec() );
		SetIdentificationAttributeOfFoldingPlan( plan, id );
		SetOrientedFaceMapAttributeOfFoldingPlan( plan, 
					__SIMPLICIAL_CreateMapFromListNC(orFaceList, false) );

		return plan;
	end
);
InstallMethod( FoldingPlanByLists, "for four lists", 
	[IsList,IsList,IsList,IsList],
	function( vertexList, edgeList, faceList, orFaceList )
		local id, plan, map;

		id := SimplicialSurfaceIdentificationByLists( 
										vertexList, edgeList, faceList );
		
		plan := Objectify( FoldingPlanType, rec() );
		SetIdentificationAttributeOfFoldingPlan( plan, id );

		# Check whether the list is well defined
		if Length(orFaceList) <> 1 or not IsList( orFaceList[1] ) or
			 Length( orFaceList[1] ) <> 2 or not IsInt( orFaceList[1][1] ) or
			not IsInt(orFaceList[1][2]) then
			Error("FoldingPlanByLists: The list for oriented faces has to consist of a single tuple of integers.");
		fi;

		SetOrientedFaceMapAttributeOfFoldingPlan( plan, 
					__SIMPLICIAL_CreateMapFromListNC(orFaceList, false) );

		return plan;
	end
);



##
##
##							End of constructors
##
#############################################################################
#############################################################################





#
###  This program is free software: you can redistribute it and/or modify
###  it under the terms of the GNU General Public License as published by
###  the Free Software Foundation, either version 3 of the License, or
###  (at your option) any later version.
###
###  This program is distributed in the hope that it will be useful,
###  but WITHOUT ANY WARRANTY; without even the implied warranty of
###  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
###  GNU General Public License for more details.
###
###  You should have received a copy of the GNU General Public License
###  along with this program.  If not, see <http://www.gnu.org/licenses/>.
###
