#! @DoNotReadRestOfFile

##############################################################################
##
#W  wild_simplicial_surface.gi          Simplicial         Alice Niemeyer
#W                                                        Markus Baumeister
##
##
#Y  Copyright (C) 2016-2017, Alice Niemeyer, Lehrstuhl B für Mathematik,
#Y  RWTH Aachen
##
##  This file is free software, see license information at the end.
##
##
##  The functions in this file compute with wild coloured simplicial surfaces.
##
##  There are several ways of inputting a wild coloured simplicial surface.
##
##  A wild coloured simplicial surface is created by the function 
##  WildSimplicialSurface and is a GAP object. Simplicial surfaces can be 
##  obtained as follows:
##
##  1) Given a triple <gens> of involutions, the function
##     AllWildSimplicialSurfaces(gens)  computes  all wild coloured simplicial 
##     surfaces whose faces are the moved points of the generators and whose
##     edges are determined by the 2-cycles of the generators.
##  2) Input a surface by first listing the faces, 
##     then pairs of faces making up the edges, 
##     then the face-paths for  each vertex.  A face-path is simply
##     a list of the faces in the order in which they occur around a vertex.
##     The function WildSimplicialSurfacesFromFacePath takes this input
##     and returns all wild coloured simplicial surfaces matching the
##     description
##  3) Input a wild coloured surface by the following data structure, 
##     called the *generic-surface* data structure. The generic-surface
##     data structure is the most general data structure to describe
##     surfaces and is not restricted to wild coloured surfaces only.
##     The generic-surface data structure is a list of
##      the number of vertices, edges and faces
##      then pairs of vertices making up the edges, 
##      then triples of edges making up the faces, e.g.
##      ( |V|, |E|, |F|, [ [v1,v2],...],  [[e1,e2,e3],... ] )
##       here ei is a number, which is a position in the list of edges,
##       so that the list of vertex pairs can be indexed by ei to find
##       the two vertex numbers of edges ei.
##     
##
##
##    As GAP objects, certain general methods are installed for 
##    simplicial surface objects, such as Print and Display and "=".
##
##    The mr-type of a wild coloured simplicial surface <simpsurf>
##    can be determined with the function MrTypeOfWildSimplicialSurface.
##
##    As Simplicial surfaces are GAP objects, they cannot be 
##    accessed like records.
##
##    An action of a permutation on a simplicial surface is installed, 
##    allowing us to compute the orbits of a group acting on a set of
##    simplicial surfaces.
##    
##




#InstallMethod( \<, "for two simplicial surfaces", true, 
#  [ IsWildSimplicialSurfaceRep, IsWildSimplicialSurfaceRep ], 0,
#   LtWildSimplicialSurface );



# compute the double cover - extend old mr settings
DoubleCoverOfWildSimplicialSurface := function (simpsurf)

        local gens, newgens, i, j, mrtype, MapCycle, grp, N, mrtypenew;


        N := NrOfFacesOfWildSimplicialSurface(simpsurf);

# replace a mirror (i,j) by (i, -j)(-i, j) 
# and a rotation (i,j) by (i,j)(-i,-j).
# As GAP cannot permute negative numbers we represent
# -i by i+N
MapCycle := function (c, t)

    local i, j;

    if t = 0 then return One(c); fi;

    i := c[1]; j := c[2];
    if t = 1 then
        return (i, j+N) * (i+N, j );
    elif t = 2 then
        return (i,j)*(i+N, j+N);
    fi;

end;

        gens := GeneratorsOfWildSimplicialSurface(simpsurf);
        newgens := List( gens, i-> Cycles(i,
            [ 1 .. Length(FacesOfWildSimplicialSurface(simpsurf)) ] ));

        mrtype := MrTypeOfWildSimplicialSurface(simpsurf);
        mrtypenew := [];

        for i in [ 1 .. 3 ] do
            newgens[i] := List( newgens[i], c -> MapCycle( c, mrtype[i][c[1]] ));
            newgens[i] := Product( newgens[i] );
            mrtypenew[i] := [];
            for j in [ 1 .. N ] do
                mrtypenew[i][j] := mrtype[i][j];
                mrtypenew[i][j+N] := mrtype[i][j];
            od;
        od;

        return WildSimplicialSurface( newgens[1], newgens[2], newgens[3], mrtypenew );
       
end;



#############################################################################
##
#!   @Description
#!   The function SixFoldCover takes as input a generic description of
#!   a simplicial surface.  The six fold cover of a simplicial surface is
#!   the following surface.
#!   If f is a face of the original face with edge numbers e_a, e_b and
#!   e_c, then the face is covered by the six faces of the form
#!   (f, e1, e2, e3), for which {e1, e2, e3}  = {e_a, e_b, e_c}.
#!   See Proposition 3.XX in the paper.
#!   @Arguments
#!
#!   If the optional argument mrtype is given, it has to be a list of length 
#!   3 and each entry has to be  $1$, or $2$. In this case the six fold cover 
#!   will treat the position $i$ for $i\in\{1,2,3\}$ of the three
#!   edges around a faces either as a   reflection (mirror), if the entry 
#!   in position $i$ of mrtype is 1, or as a rotation, if the entry in 
#!   position $i$ is 2. That is, the cover surface is generated by three
#!   transpositions $\sigma_i$ for $i=1,2,3$. For $i=1$, suppose $f$ and 
#!   $f'$ are faces of the surface surf such that the edges of $f$ are 
#!   $e_1, e_2$  and $e_3$ and the edges of $f'$ are  $e_1, e_a, e_b$ are 
#!   the edges $e_1, e_2$ and $e_a$ intersect in a common vertex and 
#!   the edges $e_1, e_3$ and $e_b$ intersect in a common vertex.
#!   For $i=1$ and  mrtype of position $1$ being  mirror (i.e. $1$), then 
#!   $$\sigma_1(f,e_1,e_2,e_3) = (f', e_1, e_a, e_b),$$ whereas if the 
#!   mrtype of position $1$ is a reflection (i.e. $2$), then 
#!   $$\sigma_1(f,e_1,e_2,e_3) = (f', e_1, e_b, e_a).$$ The definition
#!   of $\sigma_2$ and $\sigma_3$ are analogous, with $e_2$, respectively
#!   $e_3$ taking the role of the common edge $e_1.$
#!
#!   
#!   If the optional argument mredges is given, and mredges is a list of 
#!   length equal to the number of edges of the surface **surf** and an
#!   entry for an edge e is either 1 or 2. If the entry is 1 then 
#!   the six fold cover will treat the edge as a reflection (mirror) and 
#!   if the entry is 2  then the edge is treated as a rotation. 
#!
#!   The six fold cover is always a wild colourable simplicial surface.
#!   @Returns a wild coloured simplicial surface
#!   @Arguments surface, mrtype, bool
#!   if bool is true or not given, the mrtype specifies the behaviour of 
#!   the $\sigma_i$, if bool is false, the mrtype specifies the behaviour
#!   of the edges.
#!
InstallGlobalFunction( SixFoldCover, function( arg )

      local cover, faces, edges, vertices, gens, g, i, e, h, s, orbs, j, surf,
                   cfaces, cvertices, cedges, cgens, cg, cf, img, vtx, Faces,
                   neigh, e1, e2, p1, p2, poss, mrtype, Vertex, IsIncident,
                   f1, f2, sigi, cmrtype, mr, sigtype, GetMr, IsMirror;


      Vertex := function(e)
          return Set(surf[4][e]);
      end;

      IsIncident := function(e1, e2, e3)

          local inter;

          inter := Intersection(Vertex(e1), Vertex(e2));
          if Size(Intersection( inter, Vertex(e3) ) ) > 0 then
              return true;
          fi;
          return false;
      end;

      # Find the numbers of all faces incident to e
      # here e is an edge number
      Faces := function(e)
                local i, f;

                f := [];
                for i in [ 1 .. Length(surf[5]) ] do
                    if e in  surf[5][i] then
                        # we found a face incident to e
                        Add(f, i);
                    fi;
                od;
                return f;
        end;


        if Length(arg) < 1 or Length(arg) > 3 then 
            Error("SixFoldCover( <surf>[, <mrtype>, <bool>] )");
            return;
        fi;

        surf := [ NrOfVertices(arg[1]), NrOfEdges(arg[1]), NrOfFaces(arg[1]),
			EdgesOfGenericSimplicialSurface(arg[1]),
			FacesOfGenericSimplicialSurface(arg[1]) ];
        faces := surf[5];
        edges := surf[4];
        vertices := [1..surf[1]];

        if Length(arg) = 2 then
            mrtype := arg[2]; sigtype := true; 
            # the mrtype specifies the sigma_i
            if Length(mrtype) > 3 then 
                Error("SixFoldCover( <surf>[, <mrtype>, <bool>] )");
                return;
            fi;
        elif  Length(arg) = 1 then
            sigtype := true; # the mrtype specifies 
            mrtype := List( [1,2,3], i-> 1 ); 
            # the default is to reflect at every position
        else #length of arg is 3
            mrtype := arg[2]; sigtype := arg[3];
        fi;


        IsMirror := function(k, i)
                  if sigtype = false then
                      if  mrtype[k] <= 1 then
                          return true;
                      else return false;
                      fi;
                   fi;
                   if mrtype[i] = 1 then return true; 
                   else return false; 
                   fi;

        end;

      # first we compute the faces of the cover
      cfaces := Cartesian( [1..surf[3]], Arrangements( [1,2,3], 3 ) );
      cfaces := List( cfaces, f -> [f[1], faces[f[1]][f[2][1]], 
                                          faces[f[1]][f[2][2]], 
                                          faces[f[1]][f[2][3]] ]);

      # record the mrtype of the cover
      cmrtype := List( [1..3], j->List( cfaces, i-> 0 ));

      # new we have to compute the edges
      # we enforce that generator g maps  (f,(e_a, e_b, e_c)) to
      # itself, if f is a fixed point of g and to 
      # (f^g, e_x, e_y, e_z), where the edge of the same colour as g
      # is fixed and the remaining two are interchanged - so that

      cgens := [];
      for i in [1..3]  do
          sigi := []; # define generator g
          for j  in [1..Length(cfaces)] do
              cf := cfaces[j]; # work out the image of cf under sigi
              # e.g. cf = [1, 2, 3, 4] means face 1, edge numbers 2,3,4
              # if i=2 then we have to map along edge number 3
              # need to find the neighbour of cf along edge i
              # cf[1+i] is the edge number along which to map
              # add +1, since the first entry in cf is a face
              neigh := Faces(cf[i+1]); # the face numbers of 
                                       #the neighbouring faces
              if not cf[1] in neigh then
                  Error("cannot find neighbour of face ", cf, "\n");
              fi;
              neigh := Difference(neigh, [cf[1]] );
              if Length(neigh)=0 then
                  img := ShallowCopy(cf); # boundary edge
              else
                  neigh := neigh[1]; # the face number of the neighbour
                  img := [neigh];
                  e := surf[5][neigh]; # the edges of neigh
                  img[i+1] := cf[i+1]; # this edge remains fixed
                  # match up the other two edges
                  poss := Difference([1,2,3], [Position(e,cf[i+1])]); 
                  if Length(poss) <> 2 then Error("no matching edges"); fi;
                  # the other two possibilities for positions in e
                  # thus e[poss] are the two edges other than the edge
                  # along which we map
                  p1 := poss[1]; p2 := poss[2];
                  # cf[i+1] is an edge of face cf
                  # check whether it shares a vertex with the
                  # edge e[p1]. The vertices of both are intersected
                  e1 := e[p1]; e2 := e[p2]; # the other edges of neigh
                  poss := Difference([1,2,3], [i]); 
                  p1 := poss[1]; p2 := poss[2];
                  f1 := cfaces[j][p1+1]; 
                  f2 := cfaces[j][p2+1]; # other edges of cf

                  if sigtype = false then
			  if IsIncident(e1, f1, cf[i+1]) and mrtype[cf[i+1]] <= 1  or
			     IsIncident(e1, f2, cf[i+1]) and  mrtype[cf[i+1]] =2 then
				  img[p1+1] := e1;
				  img[p2+1] := e2;
			  else
				  img[p1+1] := e2;
				  img[p2+1] := e1;
			   fi;
			  sigi[j] := Position( cfaces, img );
			  cmrtype[i][j] := mrtype[cf[i+1]];
			  if cmrtype[i][j] = 0 then cmrtype[i][j] := 1; fi;
			  #Print( cfaces[j], "-", i, "->", img, "\n");
                  else  # we map according to positions
			  if IsIncident(e1, f1, cf[i+1]) and mrtype[i] <= 1  or
			     IsIncident(e1, f2, cf[i+1]) and  mrtype[i]=2 then
				  img[p1+1] := e1;
				  img[p2+1] := e2;
			  else
				  img[p1+1] := e2;
				  img[p2+1] := e1;
			   fi;
                      sigi[j] := Position( cfaces, img );
                      cmrtype[i][j] := mrtype[i];
                      if cmrtype[i][j] = 0 then cmrtype[i][j] := 1; fi;
                      #Print( cfaces[j], "-", i, "->", img, "\n");
                  fi;
                fi;
        
#                    if IsIncident(e1, f1) and  mrtype[cf[i+1]] <= 1 or
#                       IsIncident(e1, f2) and  mrtype[cf[i+1]] = 2 then
#                        img[p1+1] := e1;
#                        img[p2+1] := e2;
#                    else
#                        img[p1+1] := e2;
#                        img[p2+1] := e1;
#                    fi;
              
          od;

          for i in [ 1 .. Length(sigi) ] do
              if not IsBound(sigi[i]) then
                  sigi[i] := i;
              fi;
          od;

          if PermList(sigi) = fail then 
              Info( InfoSimplicial, 1, "Surface does not exist");
              Error("a");
              return false;
          fi;
          Add( cgens, PermList(sigi) );
      od;
  

      return AllWildSimplicialSurfaces( cgens, cmrtype );

end);

GenericSurfaceCommonCover := function(cov)

        local surf, i, j, edges, faces, vertices;

        surf := [];

        surf[1] := Length(cov.vertices);
        surf[2] := Length(cov.edges);
        surf[3] := Length(cov.faces);
        
        surf[4] := [];
        surf[5] := List( cov.faces, i-> [] );
        for i in [ 1.. Length(cov.faces) ] do
            for j in [ 1.. Length(cov.edges) ] do
                if i^cov.edges[j] <> i then
                    Add( surf[5][i], j );
                fi;
            od;
        od;

	return surf;

end;


end;

