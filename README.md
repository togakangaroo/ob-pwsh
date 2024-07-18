
# Table of Contents

1.  [`ob-pwsh`](#orge6e7743)
    1.  [Install with Straight](#org57e2f29)
        1.  [Instructions to install from main project URL](#org78ec7d3)
        2.  [Instructions to install with other package managers](#org08343c5)
        3.  [Instructions to install manually](#org510bd14)
        4.  [From fpvmorais fork](#org49d67af)
    2.  [Version](#org0227854)
    3.  [Simple code block running powershell (via a global dotnet core `pwsh`)](#org2b43fca)
    4.  [Powershell is fantastically self documenting](#org30508a1)
    5.  [Oh hold on, what's that? It supports variables? Oh shit!](#org245f57a)
    6.  [Cross language harmonizing barbershop quartet](#org6264e8c)
2.  [Inclusion](#org95379d8)
3.  [Work In Progress](#orgb6d51ce)
    1.  [`Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working](#orga9d8740)
    2.  [Sessions](#org91f0454)
    3.  [Post it to org mailing list](#org3e2acbb)
    4.  [Melpa package](#org67a733f)
    5.  [Inclusion in spacemacs powershell layer](#orga61bd42)
    6.  [Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?](#orge43c3ef)
    7.  [Better return object format](#orgd1f6e5d)


<a id="orge6e7743"></a>

# `ob-pwsh`

Org for powershell core! I wrote it!

Based on [`xchrishawk`'s `ob-racket` plugin](https://github.com/xchrishawk/ob-racket)

Fair warning - this is super raw


<a id="org57e2f29"></a>

## Install with Straight


<a id="org78ec7d3"></a>

### TODO Instructions to install from main project URL


<a id="org08343c5"></a>

### TODO Instructions to install with other package managers


<a id="org510bd14"></a>

### TODO Instructions to install manually


<a id="org49d67af"></a>

### From fpvmorais fork

    (use-package ob-pwsh
      :straight (ob-pwsh.el :type git
                            :repo "https://github.com/fpvmorais/ob-pwsh.git"
                            :local-repo "ob-pwsh")
      :commands
      (org-babel-execute:pwsh
       org-babel-expand-body:pwsh))


<a id="org0227854"></a>

## Version

    (org-entry-get nil "version" t)

    0.1


<a id="org2b43fca"></a>

## Simple code block running powershell (via a global dotnet core `pwsh`)

    Get-Location | foreach { "A path: " + $_.Path }

    A path: /Users/gmauer/code/ob-powershell


<a id="org30508a1"></a>

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


<a id="org245f57a"></a>

## Oh hold on, what's that? It supports variables? Oh shit!

Yup, variables. Here's a value:

987

And we can reference it by name in this code block

    )
    Write-Output "A foo value, larries and gentlemen: $foo"

    A foo value, larries and gentlemen: 987


<a id="org6264e8c"></a>

## Cross language harmonizing barbershop quartet

    return $numerator / 7

And now I can use the results of that function in this python code block with the `:var division_result=divide-it(numerator=213)` header arg

    )
    print(f'{division_result} + {another_num} is {division_result + another_num}')

    30.4285714285714
     +   987
     is 30.4285714285714
      987


<a id="org95379d8"></a>

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


<a id="orgb6d51ce"></a>

# Work In Progress


<a id="orga9d8740"></a>

## DONE `Ctrl-C Ctrl-C` Code inderect buffer thingy isn't working

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2024-07-18 Thu 16:05]</span></span>
    It thinks that there is something called `pwsh-mode` but there isn't, it's `powershell-mode`


<a id="org91f0454"></a>

## TODO Sessions

This will require digging into how eg ob-python works


<a id="org3e2acbb"></a>

## TODO Post it to org mailing list


<a id="org67a733f"></a>

## TODO Melpa package


<a id="orga61bd42"></a>

## TODO Inclusion in spacemacs powershell layer


<a id="orge43c3ef"></a>

## TODO Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?


<a id="orgd1f6e5d"></a>

## TODO Better return object format

Rather than outputting strings, convert powershell objects returned as `value` to elisp structures to take advantage of the fact tha we have a runtime

