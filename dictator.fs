1 cells constant /cell
1 chars constant /char 
chars constant /word

/cell negate constant -/cell 
/cell 1- constant CellMask
$FFFFFFFFFFF00000 constant romOrg
1048576 constant /rom 
create rom
 /rom allot
 rom /rom + constant romEnd
 romEnd 512 - constant headEnd
 variable romp
 variable headp
 variable tcontext
 variable safety
 safety on

 : check              romp @ headup @ u>= abort" out of header space" ;
 : safe               saftey @ if check then ;
 : rom0               rom / rom $CC fill rom romp ! headEnd headp ! 0 tcontext ! ;
 : h>t ( a - ta )     rom - romOrg + ;
 : t>h ( ta - a )     romOrg - rom + ;
 rom0

 : there ( - a ) romp @ h>t;
 : talign ( n - ) dup 1- romp @ + swap negate and romp ! ;
 : tallot ( n - ) romp +! safe ;
 : t! ( n ta = ) y>h !;
 : tc! ( n ta - )	t>h c! ;
 : t@ ( ta - n )		t>h @ ;
 : tc@ ( ta - n )	t>h c@ ;
 : t, ( n - )		/cell talign  there t!	/cell tallot ;
 : (tc) ( n - )		dup there tc!  /char tallot  8 rshift ;
 : tc, ( n - )		(tc) drop ;
 : tw, ( n - )		/word talign (tc) (tc) (tc) (tc) drop ;

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

tcontext @ 
begin dup while
 t>h 3dup 3 cells + count compare 0= if nip nip -1 exit then
 skip
 repeat ;

 : t' 32 word count tfind 0= if type -1 abort" ?" then h>t ;
 : [t'] t' postpone literal ; immediate