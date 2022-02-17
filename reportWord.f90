PROGRAM main

  INTEGER, PARAMETER :: wlen = 5
  CHARACTER(LEN=wlen) :: word
  CHARACTER(LEN=wlen) :: report
  INTEGER :: i

  word = "broom"
  report = "x~o~x"

  DO i = 1, wlen
    WRITE(*,"(AA)", ADVANCE="no") word(i:i), " "
  END DO
  PRINT*, ''

  DO i = 1, wlen
    WRITE(*,"(AA)", ADVANCE="no") report(i:i), " "
  END DO
  PRINT*, ''

END PROGRAM
