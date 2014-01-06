!! Copyright (C) 2013 Paulo V. C. Medeiros
!!
!! This file is part of BandUP: Band Unfolding code for Plane-wave based calculations.
!!
!! BandUP is free software: you can redistribute it and/or modify
!! it under the terms of the GNU General Public License as published by
!! the Free Software Foundation, either version 3 of the License, or
!! (at your option) any later version.
!!
!! BandUP is distributed in the hope that it will be useful,
!! but WITHOUT ANY WARRANTY; without even the implied warranty of
!! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!! GNU General Public License for more details.
!!
!! You should have received a copy of the GNU General Public License
!! along with BandUP.  If not, see <http://www.gnu.org/licenses/>.

module general_io
implicit none
PRIVATE
PUBLIC :: available_io_unit
CONTAINS 

function available_io_unit(min_unit,max_unit) result(unit_num)
! Returns a number unit_num which can be safely used in statements like
! open(file=unit_num)
implicit none
integer, intent(in),optional :: min_unit,max_unit
logical :: unit_is_opened
integer ::unit_num,int_aux,min_unit_num,max_unit_num

  if(present(min_unit).and.present(max_unit))then
    min_unit_num=min_unit
    max_unit_num=max_unit
    if(min_unit_num>max_unit_num)then
      int_aux=max_unit_num
      max_unit_num=min_unit_num
      min_unit_num=int_aux
    else
      if(min_unit_num==max_unit_num)then
        min_unit_num=10
        max_unit_num=90
      endif
    endif
  else
    min_unit_num=10
    max_unit_num=90
  endif

  unit_num=min_unit_num
  inquire(unit=unit_num,opened=unit_is_opened)
  do while((unit_is_opened).and.(unit_num<max_unit_num))
    unit_num=unit_num+1
    inquire(unit=unit_num,opened=unit_is_opened)
  enddo

end function available_io_unit


end module general_io
