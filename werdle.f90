PROGRAM main

  USE user_input
  USE word_dict

  IMPLICIT NONE

  ! Number of characters in word
  INTEGER, PARAMETER :: wlen = 5
  ! Word to be guessed
  CHARACTER(len=wlen) :: test_word
  ! User input and output strings
  CHARACTER(len=wlen) :: guess, report
  ! Loop control variables
  INTEGER :: lp, lp_test, lp_guess
  ! Arrays for status of test versus guessed word letters
  LOGICAL, DIMENSION(wlen) ::  correct, almost, has_candidate
  ! Game control variables
  LOGICAL :: guess_invalid, game_incomplete

  ! invoke dictionary reader from word_dict module to load
  ! word file
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
      guess_invalid = .NOT. in_dict(guess)
    END DO

    ! Validate inputted guess against test word
    ! correct - T where a letter in guess matches that in test
    correct = .FALSE.
    ! almost - T where a letter in guess is in test word but in different position
    almost = .FALSE.
    ! has_candidate - T where a letter in test word has been matched to a letter in guess
    ! that is correct but misplaced
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
        IF((lp_guess == lp_test) .OR. correct(lp_test) .OR. has_candidate(lp_test)) CYCLE
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

    ! End game once all letters are correct
    IF(ALL(correct)) game_incomplete = .FALSE.

  END DO
  !End user input loop        

  PRINT*, "You have won!"


END PROGRAM
