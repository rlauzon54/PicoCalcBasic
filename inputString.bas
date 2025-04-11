a$ = InputString("Test string")
print a$
for i = 1 to len(a$)
    print asc(mid$(a$,i,1))
next i

function InputString(prompt$) as String
    local r$="", b$, i, m$

    print prompt$;
    input b$:print

    for i = 1 to len(b$)
        m$ = mid$(b$,i,1)
        select case asc(m$)
            ' Left shift, right shift, ctrl, alt
            case 162, 163, 161, 165
               m$=""
        end select

        r$=r$+m$
    next i

    InputString = r$
end function