# instalation

If git is 1.65 or greater do

    git clone --recursive git@github.com:benzitohhh/.live-packs.git 

Otherwise

    git clone git@github.com:benzitohhh/.live-packs.git
    git submodule init
    git submodule update

Then modify your `~/.emacs-live.el`, adding this line:

    (live-add-packs '(~/.live-packs/immanuel_ben-pack))

Finally, modify `~/.live-packs/immanuel_ben-pack/init.el`, setting `source-directory` and `Git's contrib/git.el` appropriately.

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

Also, as of writing, emacs live uses an old version of auto-complete which conflicts with yassnippets.
The result is that autocomplete does not work for some modes (i.e. javascript).
This [patch](https://github.com/tkf/auto-complete/commit/337caa2ccc254a79f615bb2417f0d2fb9552b547.patch) fixes things.
To apply the patch:

1.`cd ~/.emacs.d`
2.`curl https://github.com/tkf/auto-complete/commit/337caa2ccc254a79f615bb2417f0d2fb9552b547.patch > ~/Desktop/acPatch.patch`
3.`git apply --check --directory=packs/live/clojure-pack/lib/auto-complete ~/Desktop/acPatch.patch`
4.`git apply --directory=packs/live/clojure-pack/lib/auto-complete ~/Desktop/acPatch.patch`

The above should modify auto-complete-config.el (removing one line, and adding 5 new lines)

# "new" html

`C-x C-f <someName>.html` then type `new` and hit `TAB`

