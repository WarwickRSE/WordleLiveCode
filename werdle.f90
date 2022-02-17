
PROGRAM main

  USE user_input
  USE word_dict
  IMPLICIT NONE

  INTEGER, PARAMETER :: wlen = 5
  CHARACTER(len=wlen) :: test_word
  CHARACTER(len=wlen) :: guess, report

  INTEGER :: lp, lp_test, lp_guess
  LOGICAL, DIMENSION(wlen) ::  correct, almost, has_candidate
 
  LOGICAL :: guess_invalid, game_incomplete

! iNVOKE DICTIONARY READER FROM word_dict module
  CALL read_dict()

  !Pick a word
  test_word = get_random()

  game_incomplete = .TRUE.
  !Loop over game plays
  DO WHILE(game_incomplete) 


  !Loop until a valid dictionary word has been entered
  guess_invalid = .TRUE.
  DO WHILE(guess_invalid)
    PRINT*, "Please enter a valid dictionary word guess"
    !Get guess from user
    guess = get_guess(wlen)
    !check guess is a dictionary word
    !guess_invalid = .NOT. in_dict(guess)
    guess_invalid = .FALSE.
  END DO

  ! Validate inputted guess against test word
  correct = .FALSE.
  almost = .FALSE.
  has_candidate = .FALSE.

  ! Check for right letter in right place
  DO lp = 1, wlen
    IF(test_word(lp:lp) .EQ. guess(lp:lp)) THEN
      correct(lp) = .TRUE.
    END IF
  END DO
  
  !Compare for right letter in wrong place, excluding
  ! right letter in right place
  ! Note: must avoid duplicate entries for this
  DO lp_guess = 1, wlen
    IF(correct(lp_guess)) CYCLE

    DO lp_test = 1, wlen
      !Skip letter if in right place or already matched
      IF((lp_guess == lp_test) .OR. correct(lp_test)) CYCLE
      IF(has_candidate(lp_test)) CYCLE
      IF(guess(lp_guess:lp_guess) .EQ. test_word(lp_test:lp_test)) THEN

        almost(lp_guess) = .TRUE.
        has_candidate(lp_test) = .TRUE.
        EXIT
      END IF
    END DO
  END DO

  ! Prepare report string
  DO lp = 1, wlen
    IF(correct(lp)) THEN
      report(lp:lp) = 'O'
    ELSE IF (almost(lp)) THEN
      report(lp:lp) = '~'
    ELSE
      report(lp:lp) = 'X'
    END IF
  END DO

  ! Report on correctness
  DO lp = 1, wlen
    WRITE(*,"(AA)", ADVANCE="no") guess(lp:lp), " "
  END DO
  PRINT*, ''

  DO lp = 1, wlen
    WRITE(*,"(AA)", ADVANCE="no") report(lp:lp), " "
  END DO
  PRINT*, ''

  IF(ALL(correct)) game_incomplete = .FALSE.
  END DO
  !End user input loop        

  PRINT*, "You have won!"


END PROGRAM
