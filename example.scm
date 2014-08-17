(use termbox)

;; Little function that gives a random colour.
(define (random-colour)
  (let ((colours
	 (list black red green yellow blue magenta cyan white)))
    (list-ref colours (random (length colours)))))

;; Initialise termbox
(init)

;; Needed to stop the script when a key is pressed.
(define running (make-parameter #t))

;; Create a list of cells of every character in the string "Hello world !!!!!!"
;; all with a black underlined foreground and a yellow background.
(define cells (create-cells "Hello world !!!!!!"
			    (style black underline) (style yellow)))

(let loop ()
  ;; Blit all the cells of the string "Hello world !!!!!!" 
  ;; at position (5 5) inside a box with a size of (6 3).
  (blit 5 5 6 3 cells)

  ;; Present all changes to the screen
  (present)

  ;; Poll for events
  (poll (lambda (mod key ch)
	  (cond

	   ;; When enter is pressed, clear the screen to a random colour.
	   ((eq? key key-enter) (clear (style black) 
				       (style (random-colour))))

	   ;; When escape is pressed stop the script.
	   ((eq? key key-esc) (running #f))))

	(lambda (w h)
	  ;; When screen is resized, print the screensize at the top-left corner
	  (bprintf 0 0
		   (style black underline) (style white)
		   "screen size ~a, ~a" w h)))


  ;; Continue running the loop as long as enter is not pressed.
  (when (running) (loop)))

;; Close termbox
(shutdown)
