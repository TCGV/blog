$(function () {

    positionFooter();
    $(window).resize(positionFooter);
    setInterval(positionFooter, 250);

    function positionFooter() {

        var $footer = $('.footer');
        var _fixed = 'navbar-fixed-bottom';
        
        var h1 = Math.round($(window).height());
        var h2 = Math.round(getBottom($footer));
        if (h1 != h2) {
            $footer.removeClass(_fixed);
            if (h1 > h2) {
                $footer.addClass(_fixed);
            }
        }
    
        function getBottom($el) {
            return $el.offset().top + $el.outerHeight();
        }
        
    }

});