$(function () {

    positionFooter();
    $(window).resize(positionFooter);
    setInterval(positionFooter, 250);

    function positionFooter() {

        var $footer = $('.footer');
        var _fixed = 'navbar-fixed-bottom';
        
        var dH = $(document).height();
        var wH = $(window).height();

        if (dH > wH) {
            if ($footer.hasClass(_fixed)) {
                $footer.removeClass(_fixed);
            }
        } else if (!$footer.hasClass(_fixed)) {
            $footer.addClass(_fixed);
        }

    }

});