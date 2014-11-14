# instalation

1) Install Emacs (at least version 24). See http://emacsformacosx.com/

2) Remove your existing `~/.emacs.d`

3) Install emacs live
```
cd ~/
git clone https://github.com/overtone/emacs-live.git
```

4) Make sure all modules are loaded
```
    cd emacs-live
    git submodule init
    git submodule update
    cd ..
```

5) Rename `emacs-live` to `.emacs.d`
```
mv emacs-live .emacs.d
```

6) install .live packs repo:
```
    cd ~/
    git clone git@github.com:benzitohhh/.live-packs.git
```

7) Create an environment file (i.e. `~/.live-packs/immanuel_ben-pack/env/not-so-shiny-now.el` ),
setting variables appropriately.

8) Create an `~/.emacs-live.el`, so that it loads environment, and the pack itself:
```
;; load environment
(load "~/.live-packs/immanuel_ben-pack/env/not-so-shiny-now.el" )

;; Specify default packs to use
(live-use-packs '(stable/foundation-pack
                  ;;stable/colour-pack
                  stable/lang-pack
                  stable/power-pack
                  stable/git-pack
                  ;;stable/org-pack
                  stable/clojure-pack
                  stable/bindings-pack
                  ))

;; load packs
(live-add-packs '(~/.live-packs/immanuel_ben-pack))
```

9) You also may want to modify ~/.emacs.d/init.el to remove the the *scratch* loading message.

Plus there are a bunch of default bindings that can be disabled in
`~/.emacs.d/packs/live/bindings-pack/config/default-bindings.el`, for example ace-jump.

# Cider (clojure stuff)

You'll need to install lein. Then add a `~/.lein/profiles.clj` containing:
```
{:user {:plugins [[cider/cider-nrepl "0.7.0"]]}}
```

You will probably also want to disable `clojure-test-conf.el` in `~/.emacs.d/packs/stable/clojure-pack/init.el`


# python code-completion

For python code-completion, [jedi](https://github.com/tkf/emacs-jedi) is used.
This needs to be installed as follows:

1. Make sure pip and virtualenv are installed
2. install jedi.el via marmalade (M-x package-list-packages)
3. Switch to jedi dir (i.e. ~/.emacs.d/elpa/jedi-0.1.2/ ) and run `make requirements`
Note this uses virtualenv to install the python dependencies.

# build-ctags-git

For better ctags support for OO javascript, add this to your `~/.ctags`

    --langdef=js
    --langmap=js:.js
    --regex-js=/([A-Za-z0-9._$]+)[ \t]*[:=][ \t]*\{/\1/,object/
    --regex-js=/([A-Za-z0-9._$()]+)[ \t]*[:=][ \t]*function[ \t]*\(/\1/,function/
    --regex-js=/function[ \t]+([A-Za-z0-9._$]+)[ \t]*\(([^)])\)/\1/,function/
    --regex-js=/([A-Za-z0-9._$]+)[ \t]*[:=][ \t]*\[/\1/,array/
    --regex-js=/([^= ]+)[ \t]*=[ \t]*[^"]'[^']*/\1/,string/
    --regex-js=/([^= ]+)[ \t]*=[ \t]*[^']"[^"]*/\1/,string/
    
    --exclude=*.min.js
    --exclude=.git
    
    --langdef=clojure
    --langmap=clojure:.clj
    --regex-clojure=/^\(def(n|macro|type|record|interface)?\-?[ \t]*([^ \t]+).*/\2/d,definition/


# js2-mode

from [Mooz](https://github.com/mooz/js2-mode/tree/emacs24)

You may want to disable this as it's fairly heavyweight. Do you really want syntax checking etc?

# javascript-mode snippets (for yasnippets)

from [David Miller](https://github.com/davidmiller/yasnips/tree/development/javascript-mode)

In etc/snippets/, you may need to simlink js2-mode to js-mode.

There's a nice piece explaining it all [here](http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/)

# auto-complete-mode

In the dictionary folder (~/.emacs.d/packs/live/clojure-pack/lib/auto-complete/dict/ ) you
may need to simlink js-mode and js2-mode to point to javascript-mode.

## ac vs yas conflict 1

As of writing, emacs live uses an old version of auto-complete which conflicts with yassnippets.
The result is that autocomplete does not work for some modes (i.e. javascript).
This [patch](https://github.com/tkf/auto-complete/commit/337caa2ccc254a79f615bb2417f0d2fb9552b547.patch) fixes things.
To apply the patch:

1.`cd ~/.emacs.d`
2.`curl https://github.com/tkf/auto-complete/commit/337caa2ccc254a79f615bb2417f0d2fb9552b547.patch > ~/Desktop/acPatch.patch`
3.`git apply --check --directory=packs/live/clojure-pack/lib/auto-complete ~/Desktop/acPatch.patch`
4.`git apply --directory=packs/live/clojure-pack/lib/auto-complete ~/Desktop/acPatch.patch`

The above should modify auto-complete-config.el (removing one line, and adding 5 new lines)

## ac vs yas conflict 2

Yas overrides ac's tab binding. As workaround, ac-expand is bound to C-`:

    (global-set-key (kbd "C-`") 'ac-expand)

# "new" html

`C-x C-f <someName>.html` then type `new` and hit `TAB`

