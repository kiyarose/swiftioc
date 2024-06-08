: round			CellMask + -/cell and ;
: dec ( a u - a u )	dup 1+ round negate headp +! ;
: padded		headp @ over 8 + -8 and 0 fill ;
			( 8 + instead of 7 + to acct. for length byte )
: place ( a u - )	padded dup headp @ c! headp @ 1+ swap move ;
: tname, ( a u - )	dec safe place ;
: th, ( n - )		-/cell headp +!  safe  headp @ ! ;
: thead, ( cfa a u - )	tname, tcontext @ th, there th, th, ;
: treveal		headp @ h>t tcontext ! ;

: lfa			tcontext @ t>h 2 cells + ;
: timmediate		lfa dup @ 1 or swap ! ;
: tcompile-only		lfa dup @ 2 or swap ! ;

: skip ( a - a' )	2 cells + @ -8 and ;

: 3dup ( abc - abcabc)	>r 2dup r@ -rot r> ;
: tfind ( a u - x T | a u F )