George Mauer


Table of Contents
_________________

1. `ob-pwsh'
.. 1. Version
.. 2. Simple code block running powershell (via a global dotnet core `pwsh')
.. 3. Powershell is fantastically self documenting
.. 4. Oh hold on, what's that? It supports variables? Oh shit!
.. 5. Cross language harmonizing barbershop quartet
2. Inclusion
3. Work In Progress
.. 1. TODO `Ctrl-C Ctrl-C' Code inderect buffer thingy isn't working
.. 2. TODO Sessions
.. 3. TODO Post it to org mailing list
.. 4. TODO Melpa package
.. 5. TODO Inclusion in spacemacs powershell layer
.. 6. TODO Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?


1 `ob-pwsh'
===========

  Org for powershell core! I wrote it!

  Based on [`xchrishawk''s `ob-racket' plugin]

  Fair warning - this is super raw


[`xchrishawk''s `ob-racket' plugin]
<https://github.com/xchrishawk/ob-racket>

1.1 Version
~~~~~~~~~~~

  ,----
  | (org-entry-get nil "version" t)
  `----

  ,----
  | 0.1
  `----


1.2 Simple code block running powershell (via a global dotnet core `pwsh')
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  ,----
  | Get-Location | foreach { "A path: " + $_.Path }
  `----

  ,----
  | A path: /Users/gmauer/code/ob-powershell
  `----


1.3 Powershell is fantastically self documenting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  For this next bit, I'd want to use `echo'. But I want to avoid
  bashisms for the purpose of this demo. I know it's an alias in
  powershell, so let's look that up

  ,----
  | get-alias echo
  `----

  ,----
  | 
  | CommandType     Name                                               Version    S
  |                                                                               o
  |                                                                               u
  |                                                                               r
  |                                                                               c
  |                                                                               e
  | -----------     ----                                               -------    -
  | Alias           echo -> Write-Output
  | 
  `----

  Pretty cool huh? Now we can use `Write-Output' in the future.


1.4 Oh hold on, what's that? It supports variables? Oh shit!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Yup, variables. Here's a value:

  987

  And we can reference it by name in this code block

  ,----
  | Write-Output "A foo value, larries and gentlemen: $foo"
  `----

  ,----
  | A foo value, larries and gentlemen: 987
  `----


1.5 Cross language harmonizing barbershop quartet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  ,----
  | return $numerator / 7
  `----

  And now I can use the results of that function in this python code
  block
  ,----
  | print(f'{division_result} + {another_num} is {division_result + another_num}')
  `----

  ,----
  | 30.4285714285714
  |  +   987
  |  is 30.4285714285714
  |   987
  `----


2 Inclusion
===========

  Add to load path so tha we can require this
  ,----
  | (add-to-list 'load-path "/Users/gmauer/code/ob-powershell/src/")
  `----

  And load it
  ,----
  | (load-file 'ob-pwsh)
  `----

  And now its loaded, you can go run the above.

  The default powershell command run is

  ,----
  | org-babel-pwsh-command
  `----

  If you installed this correctly the above should display something
  like `"pwsh"'.

  You should make sure its installed in a location visible to the
  default shell, or you can set it to another value.


3 Work In Progress
==================

3.1 TODO `Ctrl-C Ctrl-C' Code inderect buffer thingy isn't working
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  It thinks that there is something called `pwsh-mode' but there isn't,
  it's `powershell-mode'


3.2 TODO Sessions
~~~~~~~~~~~~~~~~~

  This will require digging into how eg ob-python works


3.3 TODO Post it to org mailing list
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


3.4 TODO Melpa package
~~~~~~~~~~~~~~~~~~~~~~


3.5 TODO Inclusion in spacemacs powershell layer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


3.6 TODO Ok, this is dumb but my html exports is broken. Some error that might have to do with parinfer?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
