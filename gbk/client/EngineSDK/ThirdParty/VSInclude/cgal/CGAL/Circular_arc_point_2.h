// Copyright (c) 2003-2006  INRIA Sophia-Antipolis (France).
// All rights reserved.
//
// This file is part of CGAL (www.cgal.org); you may redistribute it under
// the terms of the Q Public License version 1.0.
// See the file LICENSE.QPL distributed with CGAL.
//
// Licensees holding a valid commercial license may use this file in
// accordance with the commercial license agreement provided with the software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
// WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
//
// $URL: svn+ssh://scm.gforge.inria.fr/svn/cgal/branches/CGAL-3.2-branch/Curved_kernel/include/CGAL/Circular_arc_point_2.h $
// $Id: Circular_arc_point_2.h 28796 2006-02-26 14:20:26Z teillaud $
//
// Author(s)     : Monique Teillaud, Sylvain Pion

// Partially supported by the IST Programme of the EU as a Shared-cost
// RTD (FET Open) Project under Contract No  IST-2000-26473 
// (ECG - Effective Computational Geometry for Curves and Surfaces) 
// and a STREP (FET Open) Project under Contract No  IST-006413 
// (ACS -- Algorithms for Complex Shapes)

#ifndef CGAL_CIRCULAR_ARC_POINT_2_H
#define CGAL_CIRCULAR_ARC_POINT_2_H

namespace CGAL {

template < typename CircularKernel >
class Circular_arc_point_2
  : public CircularKernel::Kernel_base::Circular_arc_point_2
{
  typedef typename CircularKernel::Kernel_base::Circular_arc_point_2 
                                               RCircular_arc_point_2;
  typedef typename CircularKernel::Point_2     Point_2;
  typedef typename CircularKernel::Circle_2    Circle_2;

  typedef typename CircularKernel::Root_of_2   Root_of_2;

public:
  typedef typename CircularKernel::Root_for_circles_2_2 
                                               Root_for_circles_2_2;
  typedef CircularKernel                       R; 
  typedef RCircular_arc_point_2                Rep;
  

  const Rep& rep() const
  {
    return *this;
  }

  Rep& rep()
  {
    return *this;
  }

  Circular_arc_point_2()
    : RCircular_arc_point_2(typename R::Construct_circular_arc_point_2()())
  {}


  Circular_arc_point_2(const Root_for_circles_2_2 & np)
    : RCircular_arc_point_2(typename R::Construct_circular_arc_point_2()(np))
  {}

  Circular_arc_point_2(const RCircular_arc_point_2 & p)
    : RCircular_arc_point_2(p)
  {}
      
  Circular_arc_point_2(const Point_2 & p)
    : RCircular_arc_point_2(typename R::Construct_circular_arc_point_2()(p))
  {}
      
  typename Qualified_result_of
  <typename R::Compute_Circular_x_2,Circular_arc_point_2>::type
  //const Root_of_2 &
  x() const
  { 
    return typename R::Compute_Circular_x_2()(*this); 
  }

  typename Qualified_result_of
  <typename R::Compute_Circular_y_2,Circular_arc_point_2>::type
  //const Root_of_2 &
  y() const
  { 
    return typename R::Compute_Circular_y_2()(*this); 
  }

  Bbox_2  bbox() const
  { 
    return typename R::Construct_bbox_2()(*this); 
  }

};

  template < typename CircularKernel >
  inline
  bool
  operator==(const Circular_arc_point_2<CircularKernel> &p,
	     const Circular_arc_point_2<CircularKernel> &q)
  {
    return CircularKernel().equal_2_object()(p, q);
  }
  
  template < typename CircularKernel >
  inline
  bool
  operator!=(const Circular_arc_point_2<CircularKernel> &p,
	     const Circular_arc_point_2<CircularKernel> &q)
  {
    return ! (p == q);
  }
  
  template < typename CK >
  std::istream &
  operator>>(std::istream & is, Circular_arc_point_2<CK> &p)
  {
    typedef typename CK::Root_of_2               Root_of_2;
    typedef typename CK::Root_for_circles_2_2 Root_for_circles_2_2;
    
    Root_for_circles_2_2 r;
    is >> r;
    if(is)
      p = Circular_arc_point_2<CK>(r);
    return is;
  }

  template < class CK >
  std::ostream&
  operator<<(std::ostream &os, const Circular_arc_point_2<CK> &p)
  {
    return os << p.x() << " " << p.y() << " ";
  }
  
} // namespace CGAL

#endif // CGAL_CIRCULAR_ARC_POINT_2_H
