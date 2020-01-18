
# Table of Contents

1.  [`ob-pwsh`](#org73e5b63)
    1.  [Version](#org03ddef6)
    2.  [Simple code block running powershell (via a global dotnet core `pwsh`)](#org32c2ca1)
    3.  [Powershell is fantastically self documenting](#orgf7b9d0e)
    4.  [Oh hold on, what's that? It supports variables? Oh shit!](#org1bf670c)
    5.  [Cross language harmonizing barbershop quartet](#org98d0647)
2.  [Inclusion](#org2d0aa7d)
3.  [Work In Progress](#orgd869796)
    1.  [`Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working](#org36d5141)
    2.  [Sessions](#org296928b)
    3.  [Post it to org mailing list](#orgf1ccf97)
    4.  [Melpa package](#orgf7ea853)
    5.  [Inclusion in spacemacs powershell layer](#orgdcfbe1c)
    6.  [Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?](#orgb45da02)
    7.  [Better return object format](#org43a9f5b)


<a id="org73e5b63"></a>

# `ob-pwsh`

Org for powershell core! I wrote it!

Based on [`xchrishawk`'s `ob-racket` plugin](https://github.com/xchrishawk/ob-racket)

Fair warning - this is super raw


<a id="org03ddef6"></a>

## Version

    (org-entry-get nil "version" t)

    0.1


<a id="org32c2ca1"></a>

## Simple code block running powershell (via a global dotnet core `pwsh`)

    Get-Location | foreach { "A path: " + $_.Path }

    A path: /Users/gmauer/code/ob-powershell


<a id="orgf7b9d0e"></a>

## Powershell is fantastically self documenting

For this next bit, I'd want to use `echo`. But I want to avoid bashisms for the purpose of this demo. I know it's an alias in powershell, so let's look that up

    get-alias echo

    
    CommandType     Name                                               Version    S
                                                                                  o
                                                                                  u
                                                                                  r
                                                                                  c
                                                                                  e
    -----------     ----                                               -------    -
    Alias           echo -> Write-Output

Pretty cool huh? Now we can use `Write-Output` in the future.


<a id="org1bf670c"></a>

## Oh hold on, what's that? It supports variables? Oh shit!

Yup, variables. Here's a value:

987

And we can reference it by name in this code block

    Write-Output "A foo value, larries and gentlemen: $foo"

    A foo value, larries and gentlemen: 987


<a id="org98d0647"></a>

## Cross language harmonizing barbershop quartet

    return $numerator / 7

And now I can use the results of that function in this python code block with the `:var division_result=divide-it(numerator=213)` header arg

    print(f'{division_result} + {another_num} is {division_result + another_num}')

    30.4285714285714
     +   987
     is 30.4285714285714
      987


<a id="org2d0aa7d"></a>

# Inclusion

Add to load path so tha we can require this

    (add-to-list 'load-path "/Users/gmauer/code/ob-powershell/src/")

And load it

    (load-file 'ob-pwsh)

And now its loaded, you can go run the above.

The default powershell command run is

    org-babel-pwsh-command

If you installed this correctly the above should display something like `"pwsh"`.

You should make sure its installed in a location visible to the default shell, or you can set it to another value.


<a id="orgd869796"></a>

# Work In Progress


<a id="org36d5141"></a>

## TODO `Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working

It thinks that there is something called `pwsh-mode` but there isn't, it's `powershell-mode`


<a id="org296928b"></a>

## TODO Sessions

This will require digging into how eg ob-python works


<a id="orgf1ccf97"></a>

## TODO Post it to org mailing list


<a id="orgf7ea853"></a>

## TODO Melpa package


<a id="orgdcfbe1c"></a>

## TODO Inclusion in spacemacs powershell layer


<a id="orgb45da02"></a>

## TODO Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?


<a id="org43a9f5b"></a>

## TODO Better return object format

Rather than outputting strings, convert powershell objects returned as `value` to elisp structures to take advantage of the fact tha we have a runtime

