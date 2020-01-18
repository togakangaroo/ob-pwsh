
# Table of Contents

1.  [`ob-pwsh`](#org56489bb)
    1.  [Version](#org37a5bd9)
    2.  [Simple code block running powershell (via a global dotnet core `pwsh`)](#org1e13955)
    3.  [Powershell is fantastically self documenting](#org01dc960)
    4.  [Oh hold on, what's that? It supports variables? Oh shit!](#orgf2751b1)
    5.  [Cross language harmonizing barbershop quartet](#org05bd432)
2.  [Inclusion](#orge65e5ad)
3.  [Work In Progress](#orgfb5f1f4)
    1.  [`Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working](#orge92ed3d)
    2.  [Sessions](#orgec91b7a)
    3.  [Post it to org mailing list](#orgf0cdd75)
    4.  [Melpa package](#org50c29c6)
    5.  [Inclusion in spacemacs powershell layer](#org9849929)
    6.  [Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?](#orgfe22362)


<a id="org56489bb"></a>

# `ob-pwsh`

Org for powershell core! I wrote it!

Based on [`xchrishawk`'s `ob-racket` plugin](https://github.com/xchrishawk/ob-racket)

Fair warning - this is super raw


<a id="org37a5bd9"></a>

## Version

    (org-entry-get nil "version" t)

    0.1


<a id="org1e13955"></a>

## Simple code block running powershell (via a global dotnet core `pwsh`)

    Get-Location | foreach { "A path: " + $_.Path }

    A path: /Users/gmauer/code/ob-powershell


<a id="org01dc960"></a>

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


<a id="orgf2751b1"></a>

## Oh hold on, what's that? It supports variables? Oh shit!

Yup, variables. Here's a value:

987

And we can reference it by name in this code block

    Write-Output "A foo value, larries and gentlemen: $foo"

    A foo value, larries and gentlemen: 987


<a id="org05bd432"></a>

## Cross language harmonizing barbershop quartet

    return $numerator / 7

And now I can use the results of that function in this python code block with the `:var division_result=divide-it(numerator=213)` header arg

    print(f'{division_result} + {another_num} is {division_result + another_num}')

    30.4285714285714
     +   987
     is 30.4285714285714
      987


<a id="orge65e5ad"></a>

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


<a id="orgfb5f1f4"></a>

# Work In Progress


<a id="orge92ed3d"></a>

## TODO `Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working

It thinks that there is something called `pwsh-mode` but there isn't, it's `powershell-mode`


<a id="orgec91b7a"></a>

## TODO Sessions

This will require digging into how eg ob-python works


<a id="orgf0cdd75"></a>

## TODO Post it to org mailing list


<a id="org50c29c6"></a>

## TODO Melpa package


<a id="org9849929"></a>

## TODO Inclusion in spacemacs powershell layer


<a id="orgfe22362"></a>

## TODO Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?

