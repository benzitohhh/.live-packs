# js2-mode

from [Mooz](https://github.com/mooz/js2-mode/tree/emacs24)
You may want to disable this (i.e. it's a bit heavyweight, do you really want syntax checking etc?)

# javascript-mode snippets (for yasnippets)

from [David Miller](https://github.com/davidmiller/yasnips/tree/development/javascript-mode)
In etc/snippets/ , you may need to simlink js2-mode to js-mode

# auto-complete-mode

In the dictionary folder (~/.emacs.d/packs/live/clojure-pack/lib/auto-complete/dict/ ) you
may need to simlink js-mode and js2-mode to point to javascript-mode.

Also, as of writing, emacs live uses an old version of auto-complete which conflicts with yassnippets.  
This [patch](https://github.com/tkf/auto-complete/commit/337caa2ccc254a79f615bb2417f0d2fb9552b547.patch) fixes things.
To apply the patch:

1.`cd ~/.emacs.d`
2.`curl https://github.com/tkf/auto-complete/commit/337caa2ccc254a79f615bb2417f0d2fb9552b547.patch > ~/Desktop/acPatch.patch`
3.`git apply --check --directory=packs/live/clojure-pack/lib/auto-complete ~/Desktop/acPatch.patch`
4.`git apply --directory=packs/live/clojure-pack/lib/auto-complete ~/Desktop/acPatch.patch`

The above should modify auto-complete-config.el (removing one line, and adding 5 new lines)