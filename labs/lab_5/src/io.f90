module IO
    use Environment
    implicit none

    type String
        character(kind=CH_) :: ch
        type(String), pointer :: next => Null()
    end type String

    ! type String_Tree
    !     character(kind=CH_) :: ch
    !     type(String), pointer :: next => Null()
    !     type(String), pointer :: left => Null(),right => Null()
    ! end type String_Tree

    type Tree
        character :: ch
        type(Tree),pointer :: left => Null()
        type(Tree),pointer :: right => Null()
    end type Tree

    type Stack_Tree
        class(tree_node),pointer :: elem => Null()
        type(Stack_Tree),pointer :: next => Null()
    end type Stack_Tree

    type node
        class(node), pointer :: next  => Null()
    end type node

    type, extends(node) :: variable
        character(kind=CH_)  :: char = ""
    end type variable

    type, extends(variable) :: operation
    end type operation

    type tree_node
        class(tree_node), pointer :: left  => Null(), right => Null()
    end type tree_node

    type, extends(tree_node) :: tree_variable
        character(kind=CH_)  :: char = ""
    end type tree_variable

    type, extends(tree_variable) :: tree_operation
    end type tree_operation

    character(*),parameter :: format = '(a1)'
    integer :: size = 1

contains

    function Read_list(Input_File) result(List)
        class(node), pointer        :: List
        character(*), intent(in)   :: Input_File
        integer  In

        open (file=Input_File, newunit=In)
        List => Read_value(In)
        close (In)
    end function Read_list

    recursive function Read_value(In) result(Elem)
        class(node), pointer  :: Elem
        integer, intent(in)     :: In
        integer  IO

        character(kind=CH_)  :: char = ""
        
        read (In, '(a1)', iostat=IO, advance='no') char
        if (IO == 0) then
        select case (char)
            case (CH__'a':CH__'z', CH__'A':CH__'Z')
                allocate (Elem, source=variable(char=char))
            case (CH__'+', CH__'-', CH__'*', CH__'/')
                allocate (Elem, source=operation(char=char))
            case default
                print *,char," - непредвиденный символ"
        end select
        Elem%next => Read_value(In)
        else
            nullify (Elem)
        end if
    end function Read_value

    subroutine WriteResult(Output_File,Result)
        character(*),intent(in) :: Output_File, Result

        integer :: Out

        open(file=Output_File,newunit=Out,encoding=E_,status="replace")
            write(Out,*) Result
        close(Out)
    end subroutine WriteResult
end module IO