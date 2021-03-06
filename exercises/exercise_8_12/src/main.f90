program exercise_8_12
    use Environment

    implicit none
    integer, parameter :: N_ = 2
    real :: C(N_), D(N_)
    integer :: i

    do concurrent (i = 1:N_)
        C(i) = i * cos(real(i))
        D(i) = sin(real(i))**2
    end do


    print '('//N_//'f6.1)', (C(i), i=1,N_)
    print *,"------------------"
    print '('//N_//'f6.1)', (D(i), i=1,N_)
    print *,"------------------"
    print "(a,f5.2)","Scalar product is ",Scalar_product(C,D)
    
    
contains

    function Scalar_product(A, B) result(res)
        real, intent(in) :: A(:),B(:)
        real             :: res
        integer          :: A_size, B_size
        A_size = size(A,dim=1)
        B_size = size(B,dim=1)
        if (A_size == B_size) then
            res = Sum(A * B)
        else
            res = null
        end if
        ! res = sum(A*B)
    end function Scalar_product
end program exercise_8_12