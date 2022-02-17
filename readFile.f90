MODULE word_dict

  ! Dict file should be an ordered list of words, all of a single length
  ! We shall default to 5 letters

  IMPLICIT NONE
  PRIVATE
  INTEGER, PARAMETER :: wlen = 5
  CHARACTER(LEN=12), PARAMETER :: dict_file="words_5.txt"
  INTEGER :: dict_size
  CHARACTER(LEN=wlen), DIMENSION(:), ALLOCATABLE :: dict

  PUBLIC :: read_dict, get_random, in_dict

  CONTAINS

  SUBROUTINE read_dict()

    INTEGER :: file_size, newline_sz, l_num, line
    LOGICAL :: exists
    INTEGER :: stat
 
    INQUIRE(FILE=dict_file, EXIST=exists, SIZE=file_size)

    newline_sz = LEN(NEW_LINE(" "))

    IF(exists) THEN
      dict_size = file_size/(wlen+newline_sz)

      ALLOCATE(dict(dict_size))

      OPEN(101, FILE=dict_file, ACTION='read', iostat=stat)

      ! This is not a very generic way to do this, but it is valid and simple
      DO line = 1, dict_size
        READ(101, '(A6)') dict(line)
      END DO
    END IF


  END SUBROUTINE

  FUNCTION get_random()

    CHARACTER(LEN=wlen) :: get_random
    INTEGER :: ind

    ind = FLOOR(random() * dict_size)
    get_random = dict(ind)

  END FUNCTION

  FUNCTION in_dict(word)
    LOGICAL :: in_dict
    CHARACTER(LEN=wlen), INTENT(IN) :: word

    ! Dumb find. Better alphabetic bisection should really be added
    in_dict = ANY(dict == word)
  END FUNCTION


  FUNCTION random()

    LOGICAL, SAVE :: init = .FALSE.
    INTEGER :: sz, ct
    INTEGER, DIMENSION(:), ALLOCATABLE :: seed
    REAL :: random

    IF (.NOT. init) THEN
      init = .TRUE.
      CALL RANDOM_SEED(SIZE = sz)
      ALLOCATE(seed(sz))
      CALL SYSTEM_CLOCK(ct)
      seed = ct
      CALL RANDOM_SEED(PUT = seed)
      DEALLOCATE(seed)
    END IF
    CALL RANDOM_NUMBER(random)

  END FUNCTION random


END MODULE
