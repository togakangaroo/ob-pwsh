
# Table of Contents

1.  [`ob-pwsh`](#org9ac9d8a)
    1.  [Version](#org554dc90)
    2.  [Simple code block running powershell (via a global dotnet core `pwsh`)](#org471fb5d)
    3.  [Powershell is fantastically self documenting](#org0385fc3)
    4.  [Oh hold on, what's that? It supports variables? Oh shit!](#org79c7b4d)
    5.  [Cross language harmonizing barbershop quartet](#org7d6bde0)
2.  [Inclusion](#org5f924f1)
3.  [Work In Progress](#orgd4a4bc5)
    1.  [`Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working](#org1f806e0)
    2.  [Sessions](#org28f013e)
    3.  [Post it to org mailing list](#orgee52bec)
    4.  [Melpa package](#org9eea57a)
    5.  [Inclusion in spacemacs powershell layer](#orgd7450cb)
    6.  [Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?](#org86d32f2)


<a id="org9ac9d8a"></a>

# `ob-pwsh`

Org for powershell core! I wrote it!

Based on [`xchrishawk`'s `ob-racket` plugin](https://github.com/xchrishawk/ob-racket)

Fair warning - this is super raw


<a id="org554dc90"></a>

## Version

    (org-entry-get nil "version" t)

    0.1


<a id="org471fb5d"></a>

## Simple code block running powershell (via a global dotnet core `pwsh`)

    Get-Location | foreach { "A path: " + $_.Path }

    A path: /Users/gmauer/code/ob-powershell


<a id="org0385fc3"></a>

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


<a id="org79c7b4d"></a>

## Oh hold on, what's that? It supports variables? Oh shit!

Yup, variables. Here's a value:

987

And we can reference it by name in this code block

    Write-Output "A foo value, larries and gentlemen: $foo"

    A foo value, larries and gentlemen: 987


<a id="org7d6bde0"></a>

## Cross language harmonizing barbershop quartet

    return $numerator / 7

And now I can use the results of that function in this python code block

    print(f'{division_result} + {another_num} is {division_result + another_num}')

    30.4285714285714
     +   987
     is 30.4285714285714
      987


<a id="org5f924f1"></a>

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


<a id="orgd4a4bc5"></a>

# Work In Progress


<a id="org1f806e0"></a>

## TODO `Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working

It thinks that there is something called `pwsh-mode` but there isn't, it's `powershell-mode`


<a id="org28f013e"></a>

## TODO Sessions

This will require digging into how eg ob-python works


<a id="orgee52bec"></a>

## TODO Post it to org mailing list


<a id="org9eea57a"></a>

## TODO Melpa package


<a id="orgd7450cb"></a>

## TODO Inclusion in spacemacs powershell layer


<a id="org86d32f2"></a>

## TODO Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?

