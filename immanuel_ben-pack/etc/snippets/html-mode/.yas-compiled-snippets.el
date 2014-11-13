;;; Compiled snippets and support files for `html-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'html-mode
                     '(("art" "<article>$0</article>\n" "art" nil nil nil nil nil nil)
                       ("hg" "<hgroup>\n    $0\n</hgroup>\n" "hg" nil nil nil nil nil nil)
                       ("hgl" "<section>\n    <hgroup class=\"module-title\">\n        <h5>${1:Explore}</h5>\n	<h2>${2:The collection}</h2>\n    </hgroup>\n</section>$0\n" "hgl" nil nil nil nil nil nil)
                       ("inc" "<?php include(\"includes/${1:}.php\");?>$0\n" "inc" nil nil nil nil nil nil)
                       ("new" "<html>\n<head>\n<title>${1:title}</title>\n<style>\n\n</style>\n</head>\n<body>\n$0\n<script src=\"ext/jquery-1.7.1.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>\n\n<script type=\"text/javascript\" charset=\"utf-8\">\n\n</script>\n\n</body>\n</html>\n" "new" nil nil nil nil nil nil)
                       ("pic" "<div class=\"data-picture\" data-picture data-alt=\"${2:}\">\n    <div data-src=\"prototypes/${3:}/img/$3/${4:}-large.jpg\"></div>\n    <div data-src=\"prototypes/$3/img/$3/$4-small.jpg\" data-media=\"(max-width: 20em)\"></div>\n    <div data-src=\"prototypes/$3/img/$3/$4-small-retina.jpg\" data-media=\"(min-device-pixel-ratio: 1.5), (-webkit-min-device-pixel-ratio: 1.5)\"></div>\n    <div data-src=\"prototypes/$3/img/$3/$4-medium.jpg\" data-media=\"(min-width: 48em)\"></div>\n    <div data-src=\"prototypes/$3/img/$3/$4-large.jpg\" data-media=\"(min-width: 75em)\"></div>\n    <noscript><img src=\"prototypes/$3/img/$3/$4-large.jpg\" alt=\"$2\"></noscript>\n</div>$0\n" "pic" nil nil nil nil nil nil)
                       ("sect" "<section>$0</section>\n" "sect" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Wed Oct 15 19:14:08 2014
