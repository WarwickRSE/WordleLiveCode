
MODULE user_input
IMPLICIT NONE
CONTAINS

FUNCTION get_guess(wlen)
  CHARACTER(LEN=10) :: get_guess

  INTEGER, INTENT(IN) :: wlen
  LOGICAL :: valid

  !Read guess as a single string
  WRITE(*, "(A13,I1,A9)") "Enter guess (", wlen, " letters)"
  get_guess = ""
  valid = .FALSE.
  DO WHILE(.TRUE.)
    READ(*, *) get_guess
    valid = (len(adjustl(trim(get_guess))) == wlen)
    IF(valid) THEN
      EXIT
    ELSE
      PRINT*, "Please guess correct number of letters!"
    END IF
  END DO

END FUNCTION

END MODULE
