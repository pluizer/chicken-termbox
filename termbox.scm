(module termbox
	(key-f1
	 key-f2
	 key-f3
	 key-f4
	 key-f5
	 key-f6
	 key-f7
	 key-f8
	 key-f9
	 key-f10
	 key-f11
	 key-f12
	 key-insert
	 key-delete
	 key-home
	 key-end
	 key-pgup
	 key-pgdn
	 key-arrow-up
	 key-arrow-down
	 key-arrow-left
	 key-arrow-right
	 key-ctrl-tilde
	 key-ctrl-2
	 key-ctrl-a
	 key-ctrl-b
	 key-ctrl-c
	 key-ctrl-d
	 key-ctrl-e
	 key-ctrl-f
	 key-ctrl-g
	 key-backspace
	 key-ctrl-h
	 key-tab
	 key-ctrl-i
	 key-ctrl-j
	 key-ctrl-k
	 key-ctrl-l
	 key-enter
	 key-ctrl-m
	 key-ctrl-n
	 key-ctrl-o
	 key-ctrl-p
	 key-ctrl-q
	 key-ctrl-r
	 key-ctrl-s
	 key-ctrl-t
	 key-ctrl-u
	 key-ctrl-v
	 key-ctrl-w
	 key-ctrl-x
	 key-ctrl-y
	 key-ctrl-z
	 key-esc
	 key-ctrl-lsq-bracket
	 key-ctrl-3
	 key-ctrl-4
	 key-ctrl-backslash
	 key-ctrl-5
	 key-ctrl-rsq-bracket
	 key-ctrl-6
	 key-ctrl-7
	 key-ctrl-slash
	 key-ctrl-underscore
	 key-space
	 key-backspace2
	 key-ctrl-8
	 ;; Modification keys
	 mod-alt
	 ;; Colors
	 black
	 red
	 green
	 yellow
	 blue
	 magenta
	 cyan
	 white
	 ;; Attributes
	 bold
	 underline
	 reversed
	 ;; Cell
	 %create-cell
	 %create-cells
	 %create-attribute
	 create-cell
	 create-cells
	 ;; Functions
	 init
	 shutdown
	 width
	 height
	 clear
	 present
	 cursor-set!
	 hide-cursor!
	 put-cell!
	 blit
	 input-mode
	 output-mode
	 ; peek-event ; find a way to place neatly
	 poll)
	(import chicken scheme foreign)
	(use srfi-4)
	
#>
#include "termbox.h"
<#

;; Aux
(define floor-fix
  (foreign-lambda* integer ((double x)) "C_return(floor(x));"))


;; Keys
(define key-f1 (- #xffff 0))
(define key-f2 (- #xffff 1))
(define key-f3 (- #xffff 2))
(define key-f4 (- #xffff 3))
(define key-f5 (- #xffff 4))
(define key-f6 (- #xffff 5))
(define key-f7 (- #xffff 6))
(define key-f8 (- #xffff 7))
(define key-f9 (- #xffff 8))
(define key-f10 (- #xffff 9))
(define key-f11 (- #xffff 10))
(define key-f12 (- #xffff 11))
(define key-insert (- #xffff 12))
(define key-delete (- #xffff 13))
(define key-home (- #xffff 14))
(define key-end (- #xffff 15))
(define key-pgup (- #xffff 16))
(define key-pgdn (- #xffff 17))
(define key-arrow-up (- #xffff 18))
(define key-arrow-down (- #xffff 19))
(define key-arrow-left (- #xffff 20))
(define key-arrow-right (- #xffff 21))
(define key-ctrl-tilde #x00)
(define key-ctrl-2 #x00) 
(define key-ctrl-a #x01)
(define key-ctrl-b #x02)
(define key-ctrl-c #x03)
(define key-ctrl-d #x04)
(define key-ctrl-e #x05)
(define key-ctrl-f #x06)
(define key-ctrl-g #x07)
(define key-backspace #x08)
(define key-ctrl-h #x08) 
(define key-tab #x09)
(define key-ctrl-i #x09) 
(define key-ctrl-j #x0a)
(define key-ctrl-k #x0b)
(define key-ctrl-l #x0c)
(define key-enter #x0d)
(define key-ctrl-m #x0d) 
(define key-ctrl-n #x0e)
(define key-ctrl-o #x0f)
(define key-ctrl-p #x10)
(define key-ctrl-q #x11)
(define key-ctrl-r #x12)
(define key-ctrl-s #x13)
(define key-ctrl-t #x14)
(define key-ctrl-u #x15)
(define key-ctrl-v #x16)
(define key-ctrl-w #x17)
(define key-ctrl-x #x18)
(define key-ctrl-y #x19)
(define key-ctrl-z #x1a)
(define key-esc #x1b)
(define key-ctrl-lsq-bracket #x1b) 
(define key-ctrl-3 #x1b) 
(define key-ctrl-4 #x1c)
(define key-ctrl-backslash #x1c) 
(define key-ctrl-5 #x1d)
(define key-ctrl-rsq-bracket #x1d) 
(define key-ctrl-6 #x1e)
(define key-ctrl-7 #x1f)
(define key-ctrl-slash #x1f) 
(define key-ctrl-underscore #x1f) 
(define key-space #x20)
(define key-backspace2 #x7f)
(define key-ctrl-8 #x7f)
;; Modification keys
(define mod-alt #x01)
;; Colors
(define default-color #x00)
(define black #x01)
(define red #x02)
(define green #x03)
(define yellow #x04)
(define blue #x05)
(define magenta #x06)
(define cyan #x07)
(define white #x08)
;; Attributes
(define bold #x0100)
(define underline #x0200)
(define reversed #x0400)
;; Event types
(define key-event 1)
(define resize-event 2)
;; Error codes
(define error-eunsupported-terminal -1)
(define error-efailed-to-open-tty -2)
(define error-epipe-trap-error -3)
;; Hide cursor value
(define hide-cursor -1)
;; Input modes
(define input-current 0)
(define input-esc 1)
(define input-alt 2)
;; Output modes
(define output-current 0)
(define output-normal 1)
(define output-256 2)
(define output-216 3)
(define output-grayscale 4)
;; EOF
(define utf8-eof -1)

;; Event
(define-foreign-type c-event (c-pointer (struct "tb_event")))

(define create-event
  (foreign-primitive c-pointer () "
	struct tb_event event;
	C_return(&event);"))

(define event-type
  (foreign-lambda* unsigned-integer ((c-event event)) "
	C_return((unsigned int)event->type);"))

(define event-mod
  (foreign-lambda* unsigned-integer ((c-event event)) "
	C_return((unsigned int)event->mod);"))

(define event-key
  (foreign-lambda* unsigned-short ((c-event event)) "
	C_return(event->key);"))

(define event-ch
  (foreign-lambda* unsigned-integer ((c-event event)) "
	C_return(event->ch);"))

(define event-w
  (foreign-lambda* integer ((c-event event)) "
	C_return(event->w);"))

(define event-h
  (foreign-lambda* integer ((c-event event)) "
	C_return(event->h);"))

;; Cell

(define (%%create-cell cell fg bg)
  (set-finalizer!
   ((foreign-lambda* c-pointer
		     ((unsigned-integer ch)
		      (unsigned-short fg)
		      (unsigned-short bg)) "
	struct tb_cell* cell = malloc(sizeof(struct tb_cell));
	cell->ch = ch;
	cell->fg = fg;
	cell->bg = bg;
	C_return(cell);") cell fg bg)
   (foreign-lambda* void ((c-pointer cell)) "free(cell);")))

(define (%create-cell char fg bg)
  (%%create-cell
   (u32vector-ref (utf8-char-to-unicode (string char)) 0)
   fg bg))

(define (%create-cells string fg bg)
  (map (lambda (x) (%create-cell x fg bg))
       (string->list string)))

(define (%create-attribute color #!rest attributes)
  (apply bitwise-ior (cons color attributes)))

#|
Creates a cell containing a character with specific foreground and
background colours/attributes. These can then be put on screen with
the functions ''(put-cell!)'' or ''(blit)''.


''fg'' can be a list starting with a colour plus zero or more attributes:
bold, underline or reversed.


Example:
	; Create a letter ''H'' with black text and a white background.
	(create-cell #\H black white)
	; Create a letter ''H'' with black underlines text and a white background.
	(create-cell #\H (create-attributes (black underline) white)
|#
(define-syntax create-cell
  (syntax-rules ()
    ((_ char (fg attr ...) bg)
     (%create-cell char (%create-attribute fg attr ...) bg))
    ((_ char fg bg)
     (%create-cell char fg bg))))

(define-syntax create-cells
  (syntax-rules ()
    ((_ string (fg attr ...) bg)
     (%create-cells string (%create-attribute fg attr ...) bg))
    ((_ string fg bg)
     (%create-cells string fg bg))))



;; Chickens error messages will not be displayed right when Termbox is active
;; so this mess will close Termbox first, if it is running, before spitting
;; out the error message.
(define was-init (make-parameter #f))
(define old-exception-handler (current-exception-handler))

#|
Initializes the termbox library. This function should be called before any
other functions. After successful initialization, the library must be
finalized using the ''(shutdown)'' function.
|#
(define (init)
  (was-init #t)
  (current-exception-handler
   (lambda (x)
     (shutdown)
     (old-exception-handler x)))
  ((foreign-lambda void "tb_init")))
(define (shutdown)
  (when (was-init) 
	((foreign-lambda void "tb_shutdown"))
	(current-exception-handler old-exception-handler)
	(was-init #f)))

#|
Returns the size of the internal back buffer (which is the same as
terminal's window size in characters). The internal buffer can be resized
after ''(clear)'' or ''(present)'' function calls. Both dimensions have an
unspecified negative value when called before ''(init)'' or after ''(shutdown)''.
|#
(define width (foreign-lambda int "tb_width"))
(define height (foreign-lambda int "tb_height"))

#|
Clears the interbal back buffer to specific foreground and background
color/attributes which default to ''default-color''
|#
(define (clear #!optional
	       (fg default-color)
	       (bg default-color))
  ((foreign-lambda void "tb_set_clear_attributes" 
		   unsigned-short unsigned-short) fg bg)
  ((foreign-lambda void "tb_clear")))

#|
Syncronizes the internal back buffer with the terminal.
|#
(define present (foreign-lambda void "tb_present"))

#|
Sets the position of the cursor. Upper-left character is (0, 0).
|#
(define cursor-set! (foreign-lambda void "tb_set_cursor" int int))

#|
Hides the cursor. If ''(cursor-set!)'' is called after this the
cursor will be visible again. Cursor is hidden by default.
|#
(define (hide-cursor!)
  (cursor-set! hide-cursor hide-cursor))

#|
Changes cell's parameters in the internal back buffer at the specified
position.
|#
(define put-cell!
  (foreign-lambda void "tb_put_cell" int int c-pointer))

#|
Copies the buffer from 'cells' at the specified position, assuming the
buffer is a two-dimensional list of size ('w' x 'h'), represented as a
one-dimensional list containing lines of cells starting from the top.
|#
(define (blit x y w h cells)
  (let loop ((i 0) (cells cells))
    (let ((x (modulo i w))
	  (y (floor-fix (/ i w))))
      (put-cell! x y (car cells))
      (unless (null? (cdr cells))
	      (loop (+ i 1) (cdr cells))))))

#|
Sets the termbox input mode. Termbox has two input modes:
1. ''esc'' input mode.
   When ESC sequence is in the buffer and it doesn't match any known
   ESC sequence.
2. ''alt'' input mode.
   When ESC sequence is in the buffer and it doesn't match any known
   sequence => ESC enables ''mod-alt'' modifier for the next keyboard event.

Returns the current mode if node ''mode'' is given.
|#
(define (input-mode #!optional mode)
  (let ((ret
	 ((foreign-lambda int "tb_select_input_mode" int)
	  (if mode (case mode
		     ((esc) input-esc)
		     ((alt) input-alt)
		     (else (error "No such input mode.")))
	      input-current))))
    (cond ((= ret input-esc) 'esc)
	  ((= ret input-alt) 'alt)
	  (else (assert #f)))))

#|
Sets the termbox output mode. Termbox has three output options:
1. ''normal''     => [1..8]
   This mode provides 8 different colors:
     black, red, green, yellow, blue, magenta, cyan, white
   Shortcut: ''black'', ''red'' ...
   Attributes: ''bold'', ''underline'', ''reversed''

   Example usage:
       (change_cell! x y #\@ (create-attribute black bold) red)

2. ''256''        => [0..256]
   In this mode you can leverage the 256 terminal mode:
   0x00 - 0x07: the 8 colors as in ''normal''
   0x08 - 0x0f: (create-attribute colour-* bold)
   0x10 - 0xe7: 216 different colors
   0xe8 - 0xff: 24 different shades of grey

   Example usage:
       (change_cell! x y #\@ 184 240)
       (change_cell! x y #\@ #xb8 #xf0)

2. ''216''        => [0..216]
   This mode supports the 3rd range of the 256 mode only.
   But you dont need to provide an offset.

3. ''grayscale''  => [0..23]
   This mode supports the 4th range of the 256 mode only.
   But you dont need to provide an offset.

Returns the current mode if node ''mode'' is given.
|#
(define (output-mode #!optional mode)
  (let ((ret
	 ((foreign-lambda int "tb_select_output_mode" int)
	  (if mode (case mode
		     ((normal) output-normal)
		     ((256) output-256)
		     ((216) output-216)
		     ((grayscale) output-grayscale)
		     (else (error "No such output mode.")))
	      output-current))))
    (cond ((= ret output-normal) 'normal)
	  ((= ret output-256) '256)
	  ((= ret output-216) '216)
	  ((= ret output-grayscale) 'grayscale)
	  (else (assert #f)))))

(define (poll-event)
  (let ((event (create-event)))
    (if (= ((foreign-lambda int "tb_poll_event" c-event) event) -1)
	(error "poll-event error.")
	event)))

#|
Waits until there is an event availiable. If there is it
will call, if it is a key event, ''on-keypress'' which must 
be of form (lambda (mod key ch) ...).
If the event is a resize event it will kall ''on-resize'' which
must be of form (lambda (w h) ...).
|#
(define (poll on-keypress on-resize)
  (let ((event (poll-event)))
    (if (eq? (event-type event) key-event)
	(on-keypress (event-mod event)
		     (event-key event)
		     (event-ch  event))
	(on-resize (event-w event)
		   (event-h event)))))


(define utf8-char-length
  (foreign-lambda int "tb_utf8_char_length" char))

(define (utf8-char-to-unicode string)
  (let ((out (make-u32vector (string-length string))))
    ((foreign-lambda* void ((u32vector out) (c-string in)) "
	tb_utf8_char_to_unicode(out, in);") out string)
    out))

;; Is this right?
(define (utf8-unicode-to-char char)
  (let ((out (make-s8vector 6 0)))
    ((foreign-lambda* c-string ((s8vector out)
				(unsigned-integer in)) "
	tb_utf8_unicode_to_char(out, in);
	C_return(out);") out char)))
)
